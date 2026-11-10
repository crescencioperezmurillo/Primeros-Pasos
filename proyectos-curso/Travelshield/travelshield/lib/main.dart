/*
 * TravelShieldApp - Aplicación Flutter para gestión del estado de salud en viajes internacionales
 *
 * Derechos de autor © 2025 Crescencio Pérez Murillo.
 * Todos los derechos reservados.
 *
 * Uso y distribución:
 * Este código fuente y cualquier archivo asociado son propiedad exclusiva de Crescencio Pérez Murillo.
 * Queda prohibida la reproducción, distribución, modificación, o cualquier uso no autorizado
 * de este código sin la autorización previa y por escrito del titular de los derechos.
 *
 * Licencia:
 * El uso de este código está sujeto a los términos y condiciones establecidos por el titular.
 * Cualquier uso comercial o integración en proyectos derivados debe contar con la licencia adecuada.
 *
 * Exención de responsabilidad:
 * Este software se proporciona sin garantía de ningún tipo, expresa o implícita,
 * incluyendo pero no limitado a garantías de comerciabilidad o idoneidad para un propósito particular.
 *
 * Contacto:
 * Para consultas sobre licencias o permisos, por favor contactar a: contacto@travelshield.com
 */

import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';

// Punto de entrada de la aplicación TravelShield
void main() {
  runApp(const TravelShieldApp());
}

//Widget principal de la aplicación TravelShield
// Esta clase representa la pantalla inicial de la aplicación y configura
// el tema, el título, y la pantalla de inicio que se mostrará al usuario.
// Actúa como contenedor principal de la app y punto de arranque de la UI.
class TravelShieldApp extends StatelessWidget {
  const TravelShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título que aparece en el multitarea o título del app
      title: 'TravelShield',

      // Desactivar banner de debug en modo desarrollo
      debugShowCheckedModeBanner: false,

      // Definición del tema principal de la app
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),

      // Pantalla inicial que se muestra al arrancar la app
      home: const HomeScreen(),
    );
  }
}
