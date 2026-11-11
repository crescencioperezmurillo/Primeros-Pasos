import 'package:flutter/material.dart';

class NormativaScreen extends StatelessWidget {
  const NormativaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Normativa internacional de calidad'),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Contenido normativa internacional aquí',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}