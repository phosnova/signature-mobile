import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../router/router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Error
            const Icon(Icons.warning_amber_rounded, size: 100, color: Colors.orange),
            const SizedBox(height: 32),

            // Title
            Text(
              '404 - Page Not Found',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              'The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),

            // Back Button
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back to Home'),
              onPressed: () => context.go(AppRouter.home.path),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
