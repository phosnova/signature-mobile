import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature/signature.dart';

import '../../injection.dart';
import '../bloc/sign/sign_bloc.dart';
import 'signature_canvas.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  late SignatureController signatureController;

  @override
  void initState() {
    signatureController = SignatureController(penStrokeWidth: 2, penColor: Colors.black);
    super.initState();
  }

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  Future<void> saveSignature(BuildContext context) async {
    final image = await signatureController.toPngBytes();
    if (image != null) {
      getIt<SignBloc>().add(SignEvent.setImage(image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Tanda Tangan')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  SignatureCanvas(signatureController: signatureController),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Clear'),
                          onPressed: () {
                            signatureController.clear();
                            getIt<SignBloc>().add(const SignEvent.clear());
                          },
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text('Simpan'),
                          onPressed: () => saveSignature(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
