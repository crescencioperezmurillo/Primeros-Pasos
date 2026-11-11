import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appsurgiflash/data/instruments.dart';
import '../start_screen/home_screen.dart';
import 'favorites_provider.dart';
import '../flashcards_screen/flashcards_screen.dart';

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
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.white)),
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
          'FAVORITOS',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // ← Negro
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
      body: Column(
        children: [
          const SizedBox(height: 12), // espacio entre AppBar y Container
          // Bloque agregado con imagen y texto "¿Cómo funciona?"
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/kit_funciona.jpg',
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                const Text(
                  '¿Cómo funciona?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explora especialidades quirúrgicas y accede rápidamente a los instrumentos necesarios para cada tipo de intervención.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: favoriteInstruments.isEmpty
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
                        icon: const Icon(Icons.delete_forever, color: Colors.red), // ← Ícono relleno
                        tooltip: 'Eliminar de favoritos',
                        onPressed: () async {
                          final confirm = await _showConfirmationDialog(context, instrument.name);
                          if (confirm == true) {
                            favoritesProvider.toggleFavorite(instrument.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${instrument.name} eliminado de favoritos'),
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
          ),
        ],
      ),
    );
  }
}