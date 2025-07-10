import 'dart:typed_data';

import '../entities/local_file.dart';

abstract class SignatureRepository {
  Future<LocalFile?> saveSignature(Uint8List imageBytes);
  Future<List<LocalFile>?> getSavedSignatures();
  Future<bool> deleteSignature(String fileName);
}
