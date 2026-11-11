// **************************************************************
// Nombre del archivo: settings_screen.dart
// Proyecto: SurgiFlash
// Descripción: Pantalla de configuración de la aplicación.
//              ACTUALMENTE ESTA PANTALLA SE ENCUENTRA EN DESARROLLO Y NO
//              ES FUNCIONAL.
//
// Autor: Crescencio Pérez Murillo
// Fecha de creación: Abril-Julio 2025
// Última modificación: Julio 2025
//
// Derechos de autor © 2025 [Crescencio Pérez Murillo]
// Todos los derechos reservados.
//
// Esta aplicación está protegida por las leyes de derechos de autor y
// tratados internacionales. No se permite su copia, distribución o
// modificación sin el permiso explícito del autor.
//
// **************************************************************

// Importamos el framework de Flutter

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AJUSTES DE LA APP',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.green, width: 1),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade100.withAlpha(77),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, size: 80, color: Colors.green),
                SizedBox(height: 20),
                Text(
                  'SECCIÓN EN CONSTRUCCIÓN',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  'Aquí podrás cambiar el idioma, tema, notificaciones, y otras opciones personalizables.',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}