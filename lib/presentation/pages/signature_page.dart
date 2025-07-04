import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';

import '../../core/enums/signature_status.dart';
import '../../domain/entities/signature.dart';
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
    getIt.call<SignBloc>().add(const SignEvent.started());
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

    if (!mounted) return; // Cegah error jika widget sudah dispose

    if (image == null || image.isEmpty) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Tanda Tangan Kosong'),
              content: const Text('Silakan gambar tanda tangan terlebih dahulu sebelum menyimpan.'),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
            ),
      );
      return;
    }
    getIt<SignBloc>().add(SignEvent.save(image));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Tanda Tangan')),
      body: BlocListener<SignBloc, SignState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Berhasil menyimpan tanda tangan')));
          }
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal menyimpan tanda tangan')));
          }
        },
        child: SafeArea(
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
                    const Text('Tanda Tangan Tersimpan', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: BlocBuilder<SignBloc, SignState>(
                        builder: (context, state) {
                          if (state.status == SignatureStatus.loading) {
                            return const CircularProgressIndicator();
                          }
                          if (state.status == SignatureStatus.failure) {
                            return Text('Tidak ada tanda tangan yang tersimpan');
                          }
                          if (state.savedSignatures != null) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.savedSignatures!.length,
                              itemBuilder: (context, index) {
                                final signature = state.savedSignatures![index];
                                return SignatureCard(sign: signature!);
                              },
                            );
                          }
                          return const Text('Belum ada tanda tangan yang tersimpan');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignatureCard extends StatelessWidget {
  final Sign sign;
  const SignatureCard({required this.sign, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                sign.image != null
                    ? Image.file(sign.image!, fit: BoxFit.scaleDown)
                    : Text("Gambar kosong/tidak tersimpan!"),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: const Text('Hapus Tanda Tangan'),
                        content: const Text('Yakin ingin menghapus tanda tangan ini?'),
                        actions: [
                          TextButton(onPressed: () => context.pop(), child: const Text('Batal')),
                          TextButton(onPressed: null, child: const Text('Hapus', style: TextStyle(color: Colors.red))),
                        ],
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
