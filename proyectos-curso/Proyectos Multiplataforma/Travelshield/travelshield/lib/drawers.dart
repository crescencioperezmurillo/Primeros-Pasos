import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'TravelShield',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 Travelshield Inc.',
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Contacto'),
        content: const Text('Email: contacto@travelshield.com\nTeléfono: +34 123 456 789'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF00BFA6),
            ),
            child: Row(
              children: [
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
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Sobre la app'),
            onTap: () {
              Navigator.of(context).pop(); // Cierra el drawer
              _showAboutDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail_outlined),
            title: const Text('Contacto'),
            onTap: () {
              Navigator.of(context).pop(); // Cierra el drawer
              _showContactDialog(context);
            },
          ),
          // Puedes agregar más opciones aquí
        ],
      ),
    );
  }
}