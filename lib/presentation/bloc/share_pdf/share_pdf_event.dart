part of 'share_pdf_bloc.dart';

@freezed
class SharePdfEvent with _$SharePdfEvent {
  const factory SharePdfEvent.started() = _Started;
  const factory SharePdfEvent.share() = _Share;
  const factory SharePdfEvent.refresh() = _Refresh;
  const factory SharePdfEvent.togglePdfSelection(String filePath) = _TogglePdfSelection;
  const factory SharePdfEvent.enterSelectionMode(String filePath) = _EnterSelectionMode;
  const factory SharePdfEvent.exitSelectionMode() = _ExitSelectionMode;
  const factory SharePdfEvent.delete() = _Delete;
}
