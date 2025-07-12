part of 'share_pdf_bloc.dart';

@freezed
class SharePdfEvent with _$SharePdfEvent {
  const factory SharePdfEvent.started() = _Started;
  const factory SharePdfEvent.share() = _Share;
  const factory SharePdfEvent.refresh() = _Refresh;
}
