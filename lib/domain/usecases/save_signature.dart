import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../entities/local_file.dart';
import '../repositories/signature_repository.dart';

@lazySingleton
class SaveSignature {
  final SignatureRepository signatureRepository;
  SaveSignature(this.signatureRepository);

  Future<LocalFile?> call(Uint8List imageBytes) {
    return signatureRepository.saveSignature(imageBytes).then((result) => result);
  }
}
