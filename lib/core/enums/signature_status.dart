enum SignatureStatus { initial, loading, clearCanvas, failure, success }

extension SignatureStatusX on SignatureStatus {
  bool get isInitial => this == SignatureStatus.initial;
  bool get isLoadingImage => this == SignatureStatus.loading;
  bool get isClearCanvas => this == SignatureStatus.clearCanvas;
  bool get isFailure => this == SignatureStatus.failure;
  bool get isSuccess => this == SignatureStatus.success;
}

extension SignatureStatusEx on SignatureStatus {
  String get message {
    switch (this) {
      case SignatureStatus.initial:
        return 'Mengambil Data Tanda Tangan...';
      case SignatureStatus.loading:
        return 'Loading...';
      case SignatureStatus.clearCanvas:
        return 'Menghapus Tanda Tangan...';
      case SignatureStatus.failure:
        return 'Gagal Menyimpan Tanda Tangan';
      case SignatureStatus.success:
        return 'Tanda Tangan Berhasil Disimpan';
    }
  }
}
