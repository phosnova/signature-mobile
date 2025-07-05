part of 'pdf_bloc.dart';

@freezed
class PdfState with _$PdfState {
  const factory PdfState({
    required File? pdfFile,
    List<Sign>? savedSignatures,
    Sign? selectedSignature,
    String? message,
    required int pdfPage,
    required double signatureScale,
  }) = _Initial;

  factory PdfState.initial() =>
      PdfState(pdfFile: null, savedSignatures: [], message: null, pdfPage: 0, signatureScale: 1.0);
}
