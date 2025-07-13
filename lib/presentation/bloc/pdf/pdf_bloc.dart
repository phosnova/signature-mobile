import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../core/enums/edit_pdf_status.dart';
import '../../../domain/entities/local_file.dart';
import '../../../domain/usecases/get_pdf.dart';
import '../../../domain/usecases/get_signature.dart';
import '../../../domain/usecases/save_pdf.dart';
import '../../../router/router.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';
part 'pdf_bloc.freezed.dart';

@lazySingleton
class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final GetSignature getSignature;
  final SavePdf savePdf;
  final GetPdf getPdf;
  PdfBloc(this.getSignature, this.savePdf, this.getPdf) : super(PdfState.initial()) {
    on<PdfEvent>((event, emit) async {
      await event.when(
        started: () => _handleStarted(emit),
        openFile: () => _handleOpenFile(emit),
        saveFile: () => _handleSaveFile(emit),
        signaturePositionChanged: (dx, dy) => _handleSingaturePositionChanged(emit, dx, dy),
        pdfPageChanged: (page) => _handlePdfPageChanged(emit, page),
        selectedSignature: (sign) => _handleSelectedSignature(emit, sign),
        pdfPageSizeChanged: (pageSize, ratio) => _handlePdfPageSizeChanged(emit, pageSize, ratio),
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

    final pdfFile = File(file.path!);

    emit(state.copyWith(pdfFile: pdfFile, message: null));
  }

  Future<void> _handleSaveFile(Emitter<PdfState> emit) async {
    emit(state.copyWith(message: 'Menyimpan PDF...', status: EditPdfStatus.loading));

    final List<int> inputBytes = state.pdfFile!.readAsBytesSync();
    final PdfDocument pdf = PdfDocument(inputBytes: inputBytes);

    final PdfPage page = pdf.pages[state.pdfPage];
    final PdfBitmap signatureImage = PdfBitmap(state.selectedSignature!.file!.readAsBytesSync());

    final realLeft = (state.signaturePosition.dx / state.pageRatio) * 1.2 + 75;
    final realTop = (state.signaturePosition.dy / state.pageRatio) * 1.2;

    final realWidth = 80.0;
    final realHeight = 80.0;

    page.graphics.drawImage(signatureImage, Rect.fromLTWH(realLeft, realTop, realWidth, realHeight));

    emit(
      state.copyWith(status: EditPdfStatus.mergePdfAndSignature, message: EditPdfStatus.mergePdfAndSignature.message),
    );
    final List<int> outputBytes = await pdf.save();
    pdf.dispose();

    final Uint8List uint8Output = Uint8List.fromList(outputBytes);

    final result = await savePdf(uint8Output);

    if (result == null) {
      emit(state.copyWith(message: 'Gagal Menyimpan PDF', status: EditPdfStatus.failure));
      return Future.value();
    }

    emit(
      state.copyWith(
        updatedPdf: result,
        message: 'PDF Berhasil Disimpan',
        status: EditPdfStatus.success,
        pdfFile: null,
      ),
    );
    goRouter.pop();

    emit(state.copyWith(message: null, status: EditPdfStatus.initial, selectedSignature: null));
  }

  Future<void> _handleSingaturePositionChanged(Emitter<PdfState> emit, double dx, double dy) async {
    emit(state.copyWith(signaturePosition: Offset(state.signaturePosition.dx + dx, state.signaturePosition.dy + dy)));
  }

  Future<void> _handlePdfPageChanged(Emitter<PdfState> emit, int page) async {
    emit(state.copyWith(pdfPage: page));
  }

  Future<void> _handleSelectedSignature(Emitter<PdfState> emit, LocalFile signature) async {
    emit(state.copyWith(selectedSignature: signature));
  }

  Future<void> _handlePdfPageSizeChanged(Emitter<PdfState> emit, Size pageSize, ratio) async {
    emit(state.copyWith(pdfPageSize: pageSize, pageRatio: ratio));
  }
}
