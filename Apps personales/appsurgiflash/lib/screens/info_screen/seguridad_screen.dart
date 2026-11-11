import 'package:flutter/material.dart';

class SeguridadScreen extends StatelessWidget {
  const SeguridadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguridad del paciente y del personal quirúrgico'),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Contenido seguridad del paciente aquí',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}