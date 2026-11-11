import 'package:flutter/material.dart';
import 'package:appsurgiflash/data/instruments.dart';
import 'package:flip_card/flip_card.dart';
import '../start_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:appsurgiflash/screens/drawer_screen/favorites_provider.dart';

class FlashcardsScreen extends StatelessWidget {
  const FlashcardsScreen({super.key});

  Future<void> _openFlashcard(BuildContext context, Instrument instrument) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SingleFlashcardScreen(
          instrument: instrument,
          showFavoriteButton: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Instrument>> categorized = {};
    for (var inst in instrumentsList) {
      categorized.putIfAbsent(inst.category, () => []).add(inst);
    }
    for (var list in categorized.values) {
      list.sort((a, b) => a.name.compareTo(b.name));
    }
    final sortedCategories = categorized.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.green, width: 1)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'FLASHCARDS',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FAFB), Color(0xFFF0F0F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Bloque agregado "¿Cómo funciona?"
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
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: sortedCategories.length,
                itemBuilder: (context, index) {
                  final category = sortedCategories[index];
                  final instruments = categorized[category]!;

                  return ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.green.shade600, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/categories/${category.toLowerCase().replaceAll(' ', '_')}.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.category, size: 40, color: Colors.green),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: LayoutBuilder(builder: (context, constraints) {
                              double fontSize = 20;
                              if (constraints.maxWidth < 150) fontSize = 14;
                              else if (constraints.maxWidth < 200) fontSize = 16;
                              return Text(
                                category,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    children: instruments.map((instrument) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.shade600, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            instrument.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(Icons.chevron_right, color: Colors.green.shade700),
                          onTap: () => _openFlashcard(context, instrument),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleFlashcardScreen extends StatelessWidget {
  final Instrument instrument;
  final bool showFavoriteButton;

  const SingleFlashcardScreen({
    super.key,
    required this.instrument,
    this.showFavoriteButton = true,
  });

  void _showSnackbar(BuildContext context, String title, String? content) {
    final message = '$title: ${content ?? "No disponible"}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.green[200],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.green, width: 1)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Cambiado a negro
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          instrument.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          if (showFavoriteButton)
            Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                final isFav = favoritesProvider.isFavorite(instrument.id);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.white,
                  ),
                  onPressed: () => favoritesProvider.toggleFavorite(instrument.id),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F0F0), Color(0xFFE0E0E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _showSnackbar(context, 'Riesgo', instrument.risk),
                    icon: const Icon(Icons.warning),
                    label: const Text(
                      'Riesgo',
                      style: TextStyle(color: Colors.black), // Texto negro
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showSnackbar(context, 'Material', instrument.material),
                    icon: const Icon(Icons.build),
                    label: const Text(
                      'Material',
                      style: TextStyle(color: Colors.black), // Texto negro
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showSnackbar(context, 'Experiencia', instrument.experience),
                    icon: const Icon(Icons.school),
                    label: const Text(
                      'Experiencia',
                      style: TextStyle(color: Colors.black), // Texto negro
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showSnackbar(context, 'Frecuencia', instrument.frequency),
                    icon: const Icon(Icons.repeat),
                    label: const Text(
                      'Frecuencia',
                      style: TextStyle(color: Colors.black), // Texto negro
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _showSnackbar(context, 'Otros', instrument.others),
                    icon: const Icon(Icons.more_horiz),
                    label: const Text(
                      'Otros',
                      style: TextStyle(color: Colors.black), // Texto negro
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double maxWidth = constraints.maxWidth < 350 ? constraints.maxWidth : 350;
                  final double maxHeight = constraints.maxHeight < 480 ? constraints.maxHeight : 480;

                  return FlipCard(
                    front: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.green, width: 1),
                      ),
                      elevation: 6,
                      child: Container(
                        width: maxWidth,
                        height: maxHeight,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              instrument.image,
                              height: maxHeight * 0.4,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              instrument.name,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    back: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.green, width: 1),
                      ),
                      elevation: 6,
                      child: Container(
                        width: maxWidth,
                        height: maxHeight,
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              section('Descripción Técnica', instrument.description),
                              section('Tipo de Instrumento', instrument.category),
                              section('Función Principal', instrument.usage ?? 'No especificado'),
                              section('Especialidad Quirúrgica', instrument.comments ?? 'No disponible'),
                              section('Comentario', instrument.comments ?? 'No disponible'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget section(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }
}