import 'package:flutter/material.dart';

class FabricantesScreen extends StatelessWidget {
  const FabricantesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de fabricantes y proveedores'),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Contenido listado de fabricantes y proveedores aquí',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

