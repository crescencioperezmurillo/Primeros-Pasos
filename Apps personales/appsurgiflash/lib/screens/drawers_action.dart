import 'package:flutter/material.dart';
import 'package:appsurgiflash/screens/favorites_screen.dart';
import 'package:appsurgiflash/screens/saved_exam_screen.dart';
import 'package:appsurgiflash/screens/search_history_screen.dart';

class DrawerActions {
  static void showFavoritesInDevelopment(BuildContext context) {
    Navigator.pop(context); // Cierra el drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FavoritesScreen()),
    );
  }

  static void showSavedExams(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SavedExamsScreen()),
    );
  }

  static void showSearchHistory(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchHistoryScreen(fromSearchScreen: false)),
    );
  }

  static void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green[100],
        title: const Text(
          'Sobre SURGIFLASH',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Aplicación educativa para aprender sobre instrumental quirúrgico.',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text('Versión: 1.0.0', style: TextStyle(color: Colors.black87, fontSize: 16)),
            SizedBox(height: 8),
            Text(
              'Licencias disponibles en la documentación.',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  static void showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green[100],
        title: const Text(
          'Contacto',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          '¿Tienes preguntas o sugerencias?\n\nEscríbenos a:\nsoporte@surgiflash.com',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green[50],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[400],
              ),
              child: const Center(
                child: Text(
                  'SURGIFLASH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial de búsqueda'),
              onTap: () => DrawerActions.showSearchHistory(context),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () => DrawerActions.showFavoritesInDevelopment(context),
            ),
            ListTile(
              leading: const Icon(Icons.folder_shared),
              title: const Text('Exámenes guardados'),
              onTap: () => DrawerActions.showSavedExams(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre SURGIFLASH'),
              onTap: () => DrawerActions.showAboutDialog(context),
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contacto'),
              onTap: () => DrawerActions.showContactDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}