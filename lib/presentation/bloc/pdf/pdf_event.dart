part of 'pdf_bloc.dart';

@freezed
class PdfEvent with _$PdfEvent {
  const factory PdfEvent.started() = _Started;
  const factory PdfEvent.openFile() = _OpenFile;
  const factory PdfEvent.saveFile() = _SaveFile;
  const factory PdfEvent.deleteFile(String fileName) = _DeleteFile;
  const factory PdfEvent.shareFile(File file) = _ShareFile;
  const factory PdfEvent.signaturePositionChanged(double dx, double dy) = _SignaturePositionChanged;
  const factory PdfEvent.signatureScaleChanged(double scale) = _SignatureScaleChanged;
  const factory PdfEvent.pdfPageChanged(int page) = _PdfPageChanged;
  const factory PdfEvent.selectedSignature(LocalFile selectedSignature) = _SelectedSignature;
  const factory PdfEvent.pdfPageSizeChanged(Size pageSize, double ratio) = _PdfPageSizeChanged;
  const factory PdfEvent.getSavedPdf() = _GetSavedPdf;
}
