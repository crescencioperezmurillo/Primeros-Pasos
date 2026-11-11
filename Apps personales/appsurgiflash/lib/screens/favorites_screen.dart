import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appsurgiflash/data/instruments.dart';
import 'home_screen.dart';
import 'favorites_provider.dart';
import 'flashcards_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<bool?> _showConfirmationDialog(BuildContext context, String instrumentName) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Seguro que quieres eliminar "$instrumentName" de favoritos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Cancelar
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Confirmar
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteIds = favoritesProvider.favorites;

    final favoriteInstruments = instrumentsList
        .where((instrument) => favoriteIds.contains(instrument.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        centerTitle: true,
        title: const Text(
          'Favoritos',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          tooltip: 'Volver al menú principal',
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
            );
          },
        ),
      ),
      body: favoriteInstruments.isEmpty
          ? const Center(
        child: Text(
          'Aún no tienes instrumentos favoritos.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: favoriteInstruments.length,
        itemBuilder: (context, index) {
          final instrument = favoriteInstruments[index];
          return ListTile(
            title: Text(instrument.name),
            subtitle: Text(instrument.category),
            leading: Image.asset(
              instrument.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon:
                  const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: 'Eliminar de favoritos',
                  onPressed: () async {
                    final confirm = await _showConfirmationDialog(context, instrument.name);
                    if (confirm == true) {
                      favoritesProvider.toggleFavorite(instrument.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${instrument.name} eliminado de favoritos'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SingleFlashcardScreen(
                    instrument: instrument,
                    showFavoriteButton: false,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}