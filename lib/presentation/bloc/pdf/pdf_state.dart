part of 'pdf_bloc.dart';

@freezed
class PdfState with _$PdfState {
  const factory PdfState({
    required File? pdfFile,
    List<Sign>? savedSignatures,
    Sign? selectedSignature,
    String? message,
    required Size pdfPageSize,
    required Offset signaturePosition,
    required int pdfPage,
    required double signatureScale,
  }) = _Initial;

  factory PdfState.initial() => PdfState(
    pdfFile: null,
    savedSignatures: [],
    message: null,
    pdfPageSize: Size(0, 0),
    pdfPage: 0,
    signatureScale: 1.0,
    signaturePosition: Offset(0, 0),
  );
}
