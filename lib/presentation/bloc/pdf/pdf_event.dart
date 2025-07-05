part of 'pdf_bloc.dart';

@freezed
class PdfEvent with _$PdfEvent {
  const factory PdfEvent.started() = _Started;
  const factory PdfEvent.openFile() = _OpenFile;
  const factory PdfEvent.saveFile(File file) = _SaveFile;
  const factory PdfEvent.deleteFile(String fileName) = _DeleteFile;
  const factory PdfEvent.shareFile(File file) = _ShareFile;
  const factory PdfEvent.signaturePositionChanged(double dx, double dy) = _SignaturePositionChanged;
  const factory PdfEvent.signatureScaleChanged(double scale) = _SignatureScaleChanged;
  const factory PdfEvent.pdfPageChanged(int page) = _PdfPageChanged;
  const factory PdfEvent.selectedSignature(Sign selectedSignature) = _SelectedSignature;
}
