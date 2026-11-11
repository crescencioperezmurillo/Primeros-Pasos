import 'package:flutter/material.dart';
import 'package:appsurgiflash/data/instruments.dart';
import 'package:appsurgiflash/screens/flashcards_screen/flashcards_screen.dart';
import '../buscar_screen/search_history.dart';
import '../start_screen/home_screen.dart';

class SearchHistoryScreen extends StatefulWidget {
  final bool fromSearchScreen;

  const SearchHistoryScreen({Key? key, this.fromSearchScreen = false}) : super(key: key);

  @override
  State<SearchHistoryScreen> createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
  List<SearchEntry> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await SearchHistory.getHistory();
    setState(() {
      _history = history;
    });
  }

  Future<void> _clearHistory() async {
    await SearchHistory.clearHistory();
    setState(() {
      _history = [];
    });
  }

  Future<void> _removeTermAt(int index) async {
    final newHistory = List<SearchEntry>.from(_history);
    newHistory.removeAt(index);
    await SearchHistory.clearHistory();
    for (final entry in newHistory) {
      await SearchHistory.addSearchEntry(entry);
    }
    setState(() {
      _history = newHistory;
    });
  }

  void _openFlashcardFromResult(String result) {
    try {
      final instrument = instrumentsList.firstWhere(
            (i) => i.name.toLowerCase() == result.toLowerCase(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SingleFlashcardScreen(instrument: instrument),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se encontró información para "$result".')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        centerTitle: true,
        title: const Text(
          'HISTORIAL DE BÚSQUEDA',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          tooltip: 'Volver',
          onPressed: () {
            if (widget.fromSearchScreen) {
              Navigator.pop(context);
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
              );
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            tooltip: 'Borrar historial',
            onPressed: _history.isEmpty
                ? null
                : () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text('Confirmar'),
                  content: const Text('¿Quieres borrar todo el historial?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onPressed: () {
                        _clearHistory();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Borrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
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
            child: _history.isEmpty
                ? const Center(
              child: Text(
                'No hay términos en el historial',
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.separated(
              itemCount: _history.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = _history[index];

                return ExpansionTile(
                  leading: const Icon(Icons.history, color: Colors.green),
                  title: Text(
                    entry.term,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    'Buscado el ${entry.timestamp.day.toString().padLeft(2, '0')}/'
                        '${entry.timestamp.month.toString().padLeft(2, '0')}/'
                        '${entry.timestamp.year} a las '
                        '${entry.timestamp.hour.toString().padLeft(2, '0')}:'
                        '${entry.timestamp.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: entry.results.map((r) {
                          return ListTile(
                            title: Text(r),
                            leading: const Icon(Icons.play_arrow, color: Colors.green),
                            onTap: () => _openFlashcardFromResult(r),
                          );
                        }).toList(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        tooltip: 'Eliminar esta entrada',
                        onPressed: () => _removeTermAt(index),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}