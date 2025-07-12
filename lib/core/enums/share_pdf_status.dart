enum SharePdfStatus { initial, loading, sharePdf, refresh, failure, success }

extension PdfStatusX on SharePdfStatus {
  bool get isInitial => this == SharePdfStatus.initial;
  bool get isLoading => this == SharePdfStatus.loading;
  bool get isFailure => this == SharePdfStatus.failure;
  bool get isSuccess => this == SharePdfStatus.success;
  bool get isRefresh => this == SharePdfStatus.refresh;
  bool get isProcess => this == SharePdfStatus.sharePdf || this == SharePdfStatus.loading;
}

extension PdfStatusEx on SharePdfStatus {
  String get message {
    switch (this) {
      case SharePdfStatus.initial:
        return 'Mengambil List PDF...';
      case SharePdfStatus.loading:
        return 'Loading...';
      case SharePdfStatus.sharePdf:
        return 'Mengirim PDF...';
      case SharePdfStatus.refresh:
        return 'Mengambil List PDF...';
      case SharePdfStatus.failure:
        return 'Gagal Mengirim PDF';
      case SharePdfStatus.success:
        return 'PDF Berhasil Dikirim';
    }
  }
}
