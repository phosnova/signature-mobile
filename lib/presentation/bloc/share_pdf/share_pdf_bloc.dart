import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enums/share_pdf_status.dart';
import '../../../domain/entities/local_file.dart';
import '../../../domain/usecases/get_pdf.dart';

part 'share_pdf_event.dart';
part 'share_pdf_state.dart';
part 'share_pdf_bloc.freezed.dart';

@lazySingleton
class SharePdfBloc extends Bloc<SharePdfEvent, SharePdfState> {
  final GetPdf getPdf;
  SharePdfBloc(this.getPdf) : super(SharePdfState.initial()) {
    on<SharePdfEvent>((event, emit) async {
      await event.when(
        started: () => _handleStarted(emit),
        share: () => _handleShare(emit),
        refresh: () => _handleRefresh(emit),
      );
    });
  }

  Future<void> _handleStarted(Emitter<SharePdfState> emit) async {
    emit(state.copyWith(status: SharePdfStatus.loading));
    final result = await getPdf();

    if (result == null) {
      emit(state.copyWith(savedPdf: null, status: SharePdfStatus.failure, message: 'Tidak ada list PDF'));
      return;
    }

    emit(state.copyWith(savedPdf: result));
  }

  Future<void> _handleShare(Emitter<SharePdfState> emit) async {}

  Future<void> _handleRefresh(Emitter<SharePdfState> emit) async {
    emit(state.copyWith(status: SharePdfStatus.loading));
    final result = await getPdf();

    if (result == null) {
      emit(state.copyWith(savedPdf: null, status: SharePdfStatus.failure, message: 'Tidak ada list PDF'));
      return;
    }

    emit(state.copyWith(savedPdf: result, status: SharePdfStatus.refresh, message: 'List Pdf Berhasil Diperbarui'));
  }
}
