part of 'sign_bloc.dart';

@freezed
class SignState with _$SignState {
  const factory SignState({
    required Uint8List? signatureImage,
    required bool isSaved,
    List<File>? savedSignatures,
    String? message,
  }) = _SignState;

  factory SignState.initial() => SignState(signatureImage: null, isSaved: false, savedSignatures: [], message: null);
}
