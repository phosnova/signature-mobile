part of 'router.dart';

class AppRouter {
  // Auth Routes
  static const login = RouteItem(name: 'login', path: '/login');

  static const register = RouteItem(name: 'register', path: '/register');

  static const profile = RouteItem(name: 'profile', path: '/profile');

  static const home = RouteItem(name: 'home', path: '/home');

  static const signature = RouteItem(name: 'signature', path: '/signature');

  static const pdf = RouteItem(name: 'pdf', path: '/pdf');

  static const savedPdf = RouteItem(name: 'saved-pdf', path: '/saved-pdf');

  static const pdfViewer = RouteItem(name: 'pdf-viewer', path: '/pdf-viewer');

  // Not Found Route
  static const notFound = RouteItem(name: 'not_found', path: '/not_found');

  // Private constructor
  AppRouter._();
}
