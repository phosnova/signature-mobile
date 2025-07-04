import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enums/signature_status.dart';
import '../../../domain/entities/signature.dart';
import '../../../domain/usecases/delete_signature.dart';
import '../../../domain/usecases/get_signature.dart';
import '../../../domain/usecases/save_signature.dart';

part 'sign_event.dart';
part 'sign_state.dart';
part 'sign_bloc.freezed.dart';

@lazySingleton
class SignBloc extends Bloc<SignEvent, SignState> {
  final SaveSignature saveSignature;
  final GetSignature getSignature;
  final DeleteSignature deleteSignature;
  SignBloc(this.saveSignature, this.getSignature, this.deleteSignature) : super(SignState.initial()) {
    on<SignEvent>((event, emit) async {
      await event.when(
        started: () => _handleStarted(emit),
        clear: () => _handleClear(emit),
        save: (imageBytes) => _handleSave(emit, imageBytes),
        delete: (fileName) => _handleDelete(emit, fileName),
      );
    });
  }

  Future<void> _handleStarted(Emitter<SignState> emit) async {
    emit(state.copyWith(status: SignatureStatus.initial, message: "Mengambil Data Tanda Tangan..."));
    final image = await getSignature.call();

    if (image.isEmpty) {
      emit(
        state.copyWith(
          savedSignatures: null,
          message: "Belum ada tanda tangan yang tersimpan",
          status: SignatureStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        savedSignatures: image,
        status: SignatureStatus.success,
        message: "Berhasil Mendapatkan Data Tanda Tangan",
      ),
    );
  }

  Future<void> _handleClear(Emitter<SignState> emit) async {
    emit(state.copyWith(signatureImage: null, status: SignatureStatus.clearCanvas));
  }

  Future<void> _handleSave(Emitter<SignState> emit, Uint8List imageBytes) async {
    emit(state.copyWith(status: SignatureStatus.loading, message: "Menyimpan Tanda Tangan..."));

    final result = await saveSignature(imageBytes);

    if (result == null) {
      emit(state.copyWith(status: SignatureStatus.failure, message: 'Gagal Menyimpan Tanda Tangan'));
      return Future.value();
    }

    final updatedSignatures = List<Sign>.from(state.savedSignatures ?? [])..add(result);

    emit(
      state.copyWith(
        savedSignatures: updatedSignatures,
        status: SignatureStatus.success,
        message: 'Tanda Tangan Berhasil Disimpan',
      ),
    );
  }

  Future<void> _handleDelete(Emitter<SignState> emit, String fileName) async {
    emit(state.copyWith(status: SignatureStatus.loading, message: "Menghapus Tanda Tangan..."));
    final result = await deleteSignature(fileName);
    if (!result) {
      emit(state.copyWith(status: SignatureStatus.failure, message: 'Gagal Menghapus Tanda Tangan'));
      return Future.value();
    }
    final signatures = await getSignature.call();
    emit(
      state.copyWith(
        savedSignatures: signatures,
        status: SignatureStatus.success,
        message: 'Tanda Tangan Berhasil Dihapus',
      ),
    );
  }
}
