part of 'sign_bloc.dart';

@freezed
class SignState with _$SignState {
  const factory SignState({
    required Uint8List? signatureImage,
    required SignatureStatus status,
    List<File>? savedSignatures,
    String? message,
  }) = _SignState;

  factory SignState.initial() =>
      SignState(signatureImage: null, savedSignatures: [], status: SignatureStatus.initial, message: null);
}
