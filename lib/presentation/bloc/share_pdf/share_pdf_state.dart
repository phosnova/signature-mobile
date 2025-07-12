part of 'share_pdf_bloc.dart';

@freezed
class SharePdfState with _$SharePdfState {
  const factory SharePdfState({SharePdfStatus? status, String? message, List<LocalFile>? savedPdf}) = _SharePdfState;

  factory SharePdfState.initial() => const SharePdfState(status: SharePdfStatus.initial, message: null, savedPdf: null);
}
