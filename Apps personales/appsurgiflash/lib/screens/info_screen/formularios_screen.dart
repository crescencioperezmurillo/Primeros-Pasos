import 'package:flutter/material.dart';

class FormulariosScreen extends StatelessWidget {
  const FormulariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formularios y checklist para control de instrumental'),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Contenido formularios y checklist aquí',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}