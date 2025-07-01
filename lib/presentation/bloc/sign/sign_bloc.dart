import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/delete_signature.dart';
import '../../../domain/usecases/get_signature.dart';
import '../../../domain/usecases/save_signature.dart';

part 'sign_event.dart';
part 'sign_state.dart';
part 'sign_bloc.freezed.dart';

@injectable
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
      );
    });
  }

  Future<void> _handleStarted(Emitter<SignState> emit) async {
    final image = await getSignature.call();

    if (image.isEmpty) {
      emit(state.copyWith(savedSignatures: null, message: "Gagal Mendapatkan Data Tanda Tangan"));
      return;
    }

    emit(state.copyWith(savedSignatures: image, isSaved: false, message: "Berhasil Mendapatkan Data Tanda Tangan"));
  }

  Future<void> _handleClear(Emitter<SignState> emit) async {
    emit(state.copyWith(signatureImage: null, isSaved: false));
  }

  Future<void> _handleSave(Emitter<SignState> emit, Uint8List imageBytes) async {
    if (state.signatureImage == null) {
      emit(state.copyWith(isSaved: false, message: 'Tanda Tangan Kosong'));
      return;
    }

    final result = await saveSignature(state.signatureImage!);

    if (!result) {
      emit(state.copyWith(isSaved: false, message: 'Gagal Menyimpan Tanda Tangan'));
      return;
    }

    emit(state.copyWith(isSaved: true, message: 'Tanda Tangan Berhasil Disimpan'));
  }
}
