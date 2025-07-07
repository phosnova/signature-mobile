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
      appBar: AppBar(
        title: const Text('Edit PDF'),
        actions: [Text('Simpan', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.blueAccent))],
        actionsPadding: EdgeInsets.only(right: 24),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<PdfBloc, PdfState>(
            builder: (context, state) {
              if (state.pdfFile == null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImportPdfSection(onTap: () => context.read<PdfBloc>().add(PdfEvent.openFile())),
                );
              }

              return Container(
                padding: EdgeInsets.symmetric(vertical: 28.0),
                height: MediaQuery.of(context).size.height * state.pageRatio,
                child: Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        child: SfPdfViewer.file(
                          state.pdfFile!,
                          key: pdfViewerKey,
                          controller: pdfViewerController,
                          pageLayoutMode: PdfPageLayoutMode.single,
                          onDocumentLoaded: (details) {
                            final ratio = details.document.pages[state.pdfPage].size.aspectRatio;
                            final pageSize = details.document.pages[state.pdfPage].size;
                            context.read<PdfBloc>().add(PdfEvent.pdfPageSizeChanged(pageSize, ratio));
                          },
                          onPageChanged:
                              (details) =>
                                  context.read<PdfBloc>().add(PdfEvent.pdfPageChanged(details.newPageNumber - 1)),
                        ),
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
                ),
              );
            },
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
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
