import 'dart:io';
import 'dart:typed_data';

abstract class SignatureRepository {
  Future<bool> saveSignature(Uint8List imageBytes);
  Future<List<File>> getSavedSignatures();
  Future<bool> deleteSignature(String fileName);
}
