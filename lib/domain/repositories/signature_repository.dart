import 'dart:typed_data';

import '../entities/signature.dart';

abstract class SignatureRepository {
  Future<Sign?> saveSignature(Uint8List imageBytes);
  Future<List<Sign>?> getSavedSignatures();
  Future<bool> deleteSignature(String fileName);
}
