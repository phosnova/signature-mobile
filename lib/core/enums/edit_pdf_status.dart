enum EditPdfStatus { initial, loading, mergePdfAndSignature, failure, success }

extension PdfStatusX on EditPdfStatus {
  bool get isInitial => this == EditPdfStatus.initial;
  bool get isLoading => this == EditPdfStatus.loading;
  bool get isFailure => this == EditPdfStatus.failure;
  bool get isSuccess => this == EditPdfStatus.success;
}

extension PdfStatusEx on EditPdfStatus {
  String get message {
    switch (this) {
      case EditPdfStatus.initial:
        return 'Mengambil Data Tanda Tangan...';
      case EditPdfStatus.loading:
        return 'Loading...';
      case EditPdfStatus.mergePdfAndSignature:
        return 'Menggabungkan PDF dan Tanda Tangan...';
      case EditPdfStatus.failure:
        return 'Gagal Menyimpan Tanda Tangan';
      case EditPdfStatus.success:
        return 'Tanda Tangan Berhasil Disimpan';
    }
  }
}
