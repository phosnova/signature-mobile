import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'signature.freezed.dart';

@freezed
abstract class Sign with _$Sign {
  const factory Sign({File? image, String? fileName, String? filePath}) = _Sign;

  const Sign._(); // Private constructor
}
