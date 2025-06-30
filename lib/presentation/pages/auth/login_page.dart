import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = false;
    final isVisible = true;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 100, width: 100),
              const SizedBox(height: 80),
              Text(
                'Your App',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('This is your brief description of the app', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 32),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline_rounded, color: Colors.grey),
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey),
                  suffixIcon:
                      isVisible
                          ? Icon(Icons.visibility_outlined, color: Colors.grey)
                          : Icon(Icons.visibility_off_outlined, color: Colors.grey),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke home page
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: isLoading ? const CircularProgressIndicator(strokeAlign: -2) : const Text('Login'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      // Navigasi ke halaman register
                      context.go('/register');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
