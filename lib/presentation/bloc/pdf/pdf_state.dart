part of 'pdf_bloc.dart';

@freezed
class PdfState with _$PdfState {
  const factory PdfState({
    required File? pdfFile,
    List<LocalFile>? savedSignatures,
    LocalFile? selectedSignature,
    List<LocalFile>? savedPdf,
    String? message,
    required Size pdfPageSize,
    required Offset signaturePosition,
    required int pdfPage,
    required double signatureScale,
    required double pageRatio,
  }) = _Initial;

  factory PdfState.initial() => PdfState(
    pdfFile: null,
    savedSignatures: [],
    savedPdf: [],
    message: null,
    pdfPageSize: Size(0, 0),
    pdfPage: 0,
    signatureScale: 1.0,
    signaturePosition: Offset(0, 0),
    pageRatio: 1.0,
  );
}
