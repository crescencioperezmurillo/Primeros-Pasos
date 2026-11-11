import 'package:flutter/material.dart';

class ReferenciasScreen extends StatelessWidget {
  const ReferenciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referencias bibliográficas'),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Contenido referencias bibliográficas aquí',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}