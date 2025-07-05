import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/signature.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';
part 'pdf_bloc.freezed.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc() : super(PdfState.initial()) {
    on<PdfEvent>((event, emit) async {
      await event.when(
        started: () => _handleStarted(emit),
        openFile: () => _handleOpenFile(emit),
        saveFile: (File file) => _handleSaveFile(emit, file),
        deleteFile: (String fileName) => _handleDeleteFile(emit, fileName),
        shareFile: (File file) => _handleShareFile(emit, file),
      );
    });
  }

  Future<void> _handleStarted(Emitter<PdfState> emit) async {}

  Future<void> _handleOpenFile(Emitter<PdfState> emit) async {}

  Future<void> _handleSaveFile(Emitter<PdfState> emit, File file) async {}

  Future<void> _handleDeleteFile(Emitter<PdfState> emit, String fileName) async {}

  Future<void> _handleShareFile(Emitter<PdfState> emit, File file) async {}
}
