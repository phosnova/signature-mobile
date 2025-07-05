import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/signature.dart';
import '../../../domain/usecases/get_signature.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';
part 'pdf_bloc.freezed.dart';

@lazySingleton
class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final GetSignature getSignature;
  PdfBloc(this.getSignature) : super(PdfState.initial()) {
    on<PdfEvent>((event, emit) async {
      await event.when(
        started: () => _handleStarted(emit),
        openFile: () => _handleOpenFile(emit),
        saveFile: (File file) => _handleSaveFile(emit, file),
        deleteFile: (String fileName) => _handleDeleteFile(emit, fileName),
        shareFile: (File file) => _handleShareFile(emit, file),
        signaturePositionChanged: (dx, dy) => _handleSingaturePositionChanged(emit, dx, dy),
        signatureScaleChanged: (scale) => _handleSignatureScaleChanged(emit, scale),
        pdfPageChanged: (page) => _handlePdfPageChanged(emit, page),
        selectedSignature: (sign) => _handleSelectedSignature(emit, sign),
      );
    });
  }

  Future<void> _handleStarted(Emitter<PdfState> emit) async {
    final signature = await getSignature();

    if (signature == null) {
      emit(state.copyWith(savedSignatures: null));
      return;
    }

    emit(state.copyWith(savedSignatures: signature));
  }

  Future<void> _handleOpenFile(Emitter<PdfState> emit) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;

    // check if the file is a pdf
    if (file.extension?.toLowerCase() != 'pdf') {
      emit(state.copyWith(message: 'File bukan PDF'));
      return;
    }

    emit(state.copyWith(pdfFile: File(file.path!), message: null));
  }

  Future<void> _handleSaveFile(Emitter<PdfState> emit, File file) async {}

  Future<void> _handleDeleteFile(Emitter<PdfState> emit, String fileName) async {}

  Future<void> _handleShareFile(Emitter<PdfState> emit, File file) async {}

  Future<void> _handleSingaturePositionChanged(Emitter<PdfState> emit, double dx, double dy) async {}

  Future<void> _handleSignatureScaleChanged(Emitter<PdfState> emit, double scale) async {}

  Future<void> _handlePdfPageChanged(Emitter<PdfState> emit, int page) async {
    emit(state.copyWith(pdfPage: page));
  }

  Future<void> _handleSelectedSignature(Emitter<PdfState> emit, Sign signature) async {
    emit(state.copyWith(selectedSignature: signature));
  }
}
