import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/enums/share_pdf_status.dart';
import '../bloc/share_pdf/share_pdf_bloc.dart';

class SavedPdfsPage extends StatelessWidget {
  const SavedPdfsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved PDFs'),
        actions: [
          GestureDetector(
            onTap: () => context.read<SharePdfBloc>().add(const SharePdfEvent.refresh()),
            child: Padding(padding: const EdgeInsets.only(right: 16.0), child: Icon(Icons.refresh_rounded)),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<SharePdfBloc, SharePdfState>(
          listenWhen: (previous, current) => previous.savedPdf != current.savedPdf,
          listener: (context, state) {
            if (state.status?.isRefresh ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? 'Berhasil Diperbarui'), duration: Duration(milliseconds: 500)),
              );
            }
          },
          builder: (context, state) {
            final pdfs = state.savedPdf;
            if (pdfs == null) {
              return const Center(child: Text('No saved PDFs'));
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;

                int crossAxisCount;
                if (maxWidth > 900) {
                  crossAxisCount = 4;
                } else if (maxWidth > 600) {
                  crossAxisCount = 3;
                } else {
                  crossAxisCount = 2;
                }

                return GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: pdfs.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = pdfs.length - 1 - index;
                    final pdf = pdfs[reversedIndex];

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: const Icon(Icons.picture_as_pdf, size: 48, color: Colors.red)),
                            Column(
                              children: [
                                Divider(color: Colors.grey.shade300),
                                const SizedBox(height: 4.0),
                                Text(
                                  pdf.fileName!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
