part of 'pdf_bloc.dart';

@freezed
class PdfState with _$PdfState {
  const factory PdfState({required File? pdfFile, List<Sign>? savedSignatures, String? message}) = _Initial;

  factory PdfState.initial() => PdfState(pdfFile: null, savedSignatures: [], message: null);
}
