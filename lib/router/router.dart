import 'package:go_router/go_router.dart';

import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/auth/register_page.dart';
import '../presentation/pages/errors/not_found_page.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/pdf_page.dart';
import '../presentation/pages/pdf_viewer_page.dart';
import '../presentation/pages/profile_page.dart';
import '../presentation/pages/saved_pdfs_page.dart';
import '../presentation/pages/signature_page.dart';
import 'router_item.dart';

part 'app_router.dart';

final goRouter = GoRouter(
  initialLocation: AppRouter.home.path,
  routes: [
    GoRoute(path: AppRouter.home.path, name: AppRouter.home.name, builder: (context, state) => const HomePage()),
    GoRoute(
      path: AppRouter.signature.path,
      name: AppRouter.signature.name,
      builder: (context, state) => const SignaturePage(),
    ),
    GoRoute(
      path: AppRouter.savedPdf.path,
      name: AppRouter.savedPdf.name,
      builder: (context, state) => const SavedPdfsPage(),
    ),
    GoRoute(
      path: AppRouter.pdfViewer.path,
      name: AppRouter.pdfViewer.name,
      builder: (context, state) => PdfViewerPage(filePath: state.extra as String),
    ),
    GoRoute(path: AppRouter.pdf.path, name: AppRouter.pdf.name, builder: (context, state) => const PdfPage()),
    GoRoute(
      path: AppRouter.notFound.path,
      name: AppRouter.notFound.name,
      builder: (context, state) => const NotFoundPage(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);
