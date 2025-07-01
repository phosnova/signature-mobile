part of 'sign_bloc.dart';

@freezed
class SignState with _$SignState {
  const factory SignState({required Uint8List? signatureImage, required bool isSaved}) = _SignState;

  factory SignState.initial() => SignState(signatureImage: null, isSaved: false);
}
