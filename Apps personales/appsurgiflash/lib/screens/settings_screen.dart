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

// Definimos y desarrollamos una clase que representa la pantalla de configuración de la app.

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

// Construimos y desarrollamos la interfaz básica de usuario de la pantalla

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        //Definimos una barra superior con el título de la pantalla.

        title: const Text('Configuración'),
      ),
      body: const Center(

        // Construimos un texto provisional que informa del estado actual.

        child: Text(
          'Aquí se podrá cambiar el idioma, tema, etc.'
          'SECCIÓN EN CONSTRUCCIÓN. PANTALLA NO FUNCIONAL',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}