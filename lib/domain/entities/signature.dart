import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'signature.freezed.dart';

@freezed
abstract class Signature with _$Signature {
  const factory Signature({Uint8List? code}) = _Signature;

  const Signature._(); // Private constructor
}
