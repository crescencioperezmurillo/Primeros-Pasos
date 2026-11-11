import 'package:flutter/material.dart';
import 'home_screen.dart';

class WarningScreen extends StatelessWidget {
  const WarningScreen({super.key}); // ✅ Constructor con key

  void continueToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 80, color: Colors.yellow),
              const SizedBox(height: 20),
              const Text(
                'Advertencia',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(height: 20),
              const Text(
                'Este contenido puede contener material sensible. Al continuar, aceptas los términos y condiciones.',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => continueToHome(context),
                child: const Text('Aceptar y continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}