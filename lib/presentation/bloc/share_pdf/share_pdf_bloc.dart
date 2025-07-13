import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/enums/share_pdf_status.dart';
import '../../../domain/entities/local_file.dart';
import '../../../domain/usecases/delete_multiple_pdf.dart';
import '../../../domain/usecases/get_pdf.dart';

part 'share_pdf_event.dart';
part 'share_pdf_state.dart';
part 'share_pdf_bloc.freezed.dart';

@lazySingleton
class SharePdfBloc extends Bloc<SharePdfEvent, SharePdfState> {
  final GetPdf getPdf;
  final DeleteMultiplePdf deleteMultiplePdf;
  SharePdfBloc(this.getPdf, this.deleteMultiplePdf) : super(SharePdfState.initial()) {
    on<SharePdfEvent>((event, emit) async {
      await event.when(
        started: () => _handleStarted(emit),
        share: () => _handleShare(emit),
        refresh: () => _handleRefresh(emit),
        enterSelectionMode: (filePath) => _handleEnterSelectionMode(emit, filePath),
        togglePdfSelection: (filePath) => _handleTogglePdfSelection(emit, filePath),
        exitSelectionMode: () => _handleExitSelectionMode(emit),
        delete: () => _handleDelete(emit),
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

  Future<void> _handleShare(Emitter<SharePdfState> emit) async {
    if (state.selectedPdfPaths == null) return;

    final files = state.selectedPdfPaths!.map((path) => XFile(path)).toList();

    SharePlus.instance.share(ShareParams(files: files));
  }

  Future<void> _handleRefresh(Emitter<SharePdfState> emit) async {
    emit(state.copyWith(status: SharePdfStatus.loading));
    final result = await getPdf();

    if (result == null) {
      emit(state.copyWith(savedPdf: null, status: SharePdfStatus.failure, message: 'Tidak ada list PDF'));
      return;
    }

    emit(state.copyWith(savedPdf: result, status: SharePdfStatus.refresh, message: 'List Pdf Berhasil Diperbarui'));
  }

  Future<void> _handleEnterSelectionMode(Emitter<SharePdfState> emit, String filePath) async {
    emit(state.copyWith(selectedPdfPaths: [filePath], isSelectionMode: true));
  }

  Future<void> _handleTogglePdfSelection(Emitter<SharePdfState> emit, String filePath) async {
    final current = List<String>.from(state.selectedPdfPaths ?? []);
    if (current.contains(filePath)) {
      current.remove(filePath);
    } else {
      current.add(filePath);
    }
    emit(state.copyWith(selectedPdfPaths: current));
  }

  Future<void> _handleExitSelectionMode(Emitter<SharePdfState> emit) async {
    emit(state.copyWith(isSelectionMode: false, selectedPdfPaths: []));
  }

  Future<void> _handleDelete(Emitter<SharePdfState> emit) async {
    final selectedPaths = state.selectedPdfPaths;
    final currentSaved = state.savedPdf;

    if (selectedPaths == null || selectedPaths.isEmpty || currentSaved == null) return;

    final filenames = selectedPaths.map((path) => path.split('/').last).toList();

    final result = await deleteMultiplePdf(filenames);

    if (result) {
      final updatedSavedPdf = currentSaved.where((pdf) => !selectedPaths.contains(pdf.filePath)).toList();

      emit(
        state.copyWith(
          status: SharePdfStatus.delete,
          isSelectionMode: false,
          message: 'PDF Berhasil Dihapus',
          selectedPdfPaths: [],
          savedPdf: updatedSavedPdf,
        ),
      );
    } else {
      emit(state.copyWith(status: SharePdfStatus.failure, message: 'Gagal menghapus PDF'));
    }
  }
}
