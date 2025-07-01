import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureCanvas extends StatelessWidget {
  final SignatureController signatureController;
  const SignatureCanvas({required this.signatureController, super.key});

  @override
  Widget build(BuildContext context) {
    return Signature(controller: signatureController, backgroundColor: Colors.grey[200]!, height: 200);
  }
}
