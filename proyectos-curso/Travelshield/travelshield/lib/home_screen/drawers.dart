/*
 * Drawer - Drawer lateral de la pantalla Home Screen de TravelShieldApp
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

// Widget que representa el menú lateral (drawer) de la aplicación
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Metodo privado para mostrar un cuadro de diálogo "Acerca de"
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'TravelShield',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 Travelshield Inc.',
    );
  }

  // Metodo privado para mostrar un cuadro de diálogo con información de contacto
  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Contacto'),
        content: const Text('Email: contacto@travelshield.com\nTeléfono: +34 123 456 789'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(), // Cierra el diálogo
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Contenido del drawer organizado en una columna
      child: Column(
        children: [
          // Encabezado del drawer con fondo personalizado y contenido
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF00BFA6), // Color de fondo personalizado
            ),
            child: Row(
              children: [
                // Imagen circular (logo o icono) a la izquierda
                ClipOval(
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Image.asset(
                      'assets/icons/icono.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Texto descriptivo al lado derecho de la imagen
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'TravelShield',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\n El compañero de viaje \n que te mantiene seguro',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Opción "Sobre la app" con icono y texto
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Sobre la app'),
            onTap: () {
              Navigator.of(context).pop(); // Cierra el drawer
              _showAboutDialog(context);   // Muestra el diálogo "Acerca de"
            },
          ),
          // Opción "Contacto" con icono y texto
          ListTile(
            leading: const Icon(Icons.contact_mail_outlined),
            title: const Text('Contacto'),
            onTap: () {
              Navigator.of(context).pop();  // Cierra el drawer
              _showContactDialog(context);  // Muestra el diálogo de contacto
            },
          ),
        ],
      ),
    );
  }
}