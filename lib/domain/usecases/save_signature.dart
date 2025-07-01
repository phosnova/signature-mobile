import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../repositories/signature_repository.dart';

@lazySingleton
class SaveSignature {
  final SignatureRepository signatureRepository;
  SaveSignature(this.signatureRepository);

  Future<bool> call(Uint8List imageBytes) => signatureRepository.saveSignature(imageBytes);
}
