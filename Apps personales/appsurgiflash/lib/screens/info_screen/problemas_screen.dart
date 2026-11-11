import 'package:flutter/material.dart';

class ProblemasScreen extends StatelessWidget {
  const ProblemasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problemas y soluciones en el instrumental quirúrgico'),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Contenido problemas y soluciones aquí',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}