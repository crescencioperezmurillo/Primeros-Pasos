import 'package:flutter/material.dart';
import 'package:appsurgiflash/screens/drawer_screen/favorites_screen.dart';
import 'package:appsurgiflash/screens/drawer_screen/saved_exam_screen.dart';
import 'package:appsurgiflash/screens/drawer_screen/search_history_screen.dart';

class DrawerActions {
  static void showFavoritesInDevelopment(BuildContext context) {
    Navigator.pop(context);
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
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sobre SURGIFLASH',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aplicación educativa para aprender sobre instrumental quirúrgico.',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            SizedBox(height: 12),
            Text('Versión: 1.0.0', style: TextStyle(color: Colors.black87, fontSize: 16)),
            SizedBox(height: 12),
            Text(
              'Licencias disponibles en la documentación.',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  static void showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Contacto',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        content: const Text(
          '¿Tienes preguntas o sugerencias?\n\nEscríbenos a:\nsoporte@surgiflash.com',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.green)),
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
              leading: const Icon(Icons.history, color: Colors.green),
              title: const Text(
                'Historial de búsqueda',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () => DrawerActions.showSearchHistory(context),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.green),
              title: const Text(
                'Favoritos',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () => DrawerActions.showFavoritesInDevelopment(context),
            ),
            ListTile(
              leading: const Icon(Icons.folder_shared, color: Colors.green),
              title: const Text(
                'Exámenes guardados',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () => DrawerActions.showSavedExams(context),
            ),
            const Divider(thickness: 1),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.green),
              title: const Text(
                'Sobre SURGIFLASH',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () => DrawerActions.showAboutDialog(context),
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.green),
              title: const Text(
                'Contacto',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () => DrawerActions.showContactDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}