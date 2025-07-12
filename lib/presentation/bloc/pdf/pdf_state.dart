part of 'pdf_bloc.dart';

@freezed
class PdfState with _$PdfState {
  const factory PdfState({
    required File? pdfFile,
    List<LocalFile>? savedSignatures,
    LocalFile? selectedSignature,
    LocalFile? updatedPdf,
    String? message,
    required EditPdfStatus status,
    required Size pdfPageSize,
    required Offset signaturePosition,
    required int pdfPage,
    required double signatureScale,
    required double pageRatio,
  }) = _Initial;

  factory PdfState.initial() => PdfState(
    pdfFile: null,
    savedSignatures: [],
    message: null,
    status: EditPdfStatus.initial,
    pdfPageSize: Size(0, 0),
    pdfPage: 0,
    signatureScale: 1.0,
    signaturePosition: Offset(0, 0),
    pageRatio: 1.0,
  );
}
