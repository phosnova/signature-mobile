import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
              const SizedBox(height: 80),
              Text('Sign Up', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              Text('Create your account', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 32),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.grey),
                  labelText: 'Nama',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                child: isLoading ? const CircularProgressIndicator(strokeAlign: -2) : const Text('Register'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      // Navigasi ke halaman register
                      context.go('/login');
                    },
                    child: const Text('Sign In'),
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
