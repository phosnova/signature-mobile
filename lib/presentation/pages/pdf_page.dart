import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../bloc/pdf/pdf_bloc.dart';
import 'signature_page.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final GlobalKey pdfViewerKey = GlobalKey();
  final PdfViewerController pdfViewerController = PdfViewerController();

  final double baseWidth = 150;
  final double baseHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit PDF')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: BlocBuilder<PdfBloc, PdfState>(
            builder: (context, state) {
              final pdfHeight = state.pdfPageSize.height;

              if (state.pdfFile == null) {
                return ImportPdfSection(onTap: () => context.read<PdfBloc>().add(PdfEvent.openFile()));
              }

              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                child: Stack(
                  children: [
                    SfPdfViewer.file(
                      state.pdfFile!,
                      key: pdfViewerKey,
                      controller: pdfViewerController,
                      onPageChanged:
                          (details) => context.read<PdfBloc>().add(PdfEvent.pdfPageChanged(details.newPageNumber - 1)),
                    ),
                    Positioned(
                      left: state.signaturePosition.dx,
                      top: state.signaturePosition.dy,
                      child: GestureDetector(
                        onPanUpdate:
                            (details) => context.read<PdfBloc>().add(
                              PdfEvent.signaturePositionChanged(details.delta.dx, details.delta.dy),
                            ),
                        child: Transform.scale(
                          scale: state.signatureScale,
                          child:
                              state.selectedSignature != null
                                  ? Image.file(
                                    File(state.selectedSignature!.image!.path),
                                    width: baseWidth,
                                    height: baseHeight,
                                  )
                                  : Container(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: BlocBuilder<PdfBloc, PdfState>(
          builder: (context, state) {
            if (state.savedSignatures == null) return const Center(child: CircularProgressIndicator());

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.savedSignatures!.length,
              itemBuilder: (context, index) {
                final signature = state.savedSignatures![index];
                final isSelected = signature == state.selectedSignature;

                return GestureDetector(
                  onTap: () => context.read<PdfBloc>().add(PdfEvent.selectedSignature(signature)),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: isSelected ? Colors.blue : Colors.grey, width: isSelected ? 3.0 : 1.0),
                    ),
                    child: SignatureCard(sign: signature, onPressed: null),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ImportPdfSection extends StatelessWidget {
  final void Function()? onTap;
  const ImportPdfSection({this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 2.0),
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.upload_file, size: 50, color: Colors.redAccent),
                Text(
                  'Import PDF',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
