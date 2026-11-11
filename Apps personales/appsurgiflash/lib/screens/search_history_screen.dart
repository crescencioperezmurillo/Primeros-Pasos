import 'package:flutter/material.dart';
import 'package:appsurgiflash/data/instruments.dart';
import 'package:appsurgiflash/screens/flashcards_screen.dart';
import 'search_history.dart';
import 'home_screen.dart';

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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se encontró información para "$result".')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
          tooltip: 'Volver',
        ),
        title: const Text('Historial de búsqueda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Borrar historial',
            onPressed: _history.isEmpty
                ? null
                : () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Confirmar'),
                  content: const Text('¿Quieres borrar todo el historial?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        _clearHistory();
                        Navigator.pop(context);
                      },
                      child: const Text('Borrar'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: _history.isEmpty
          ? const Center(child: Text('No hay términos en el historial'))
          : ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          final entry = _history[index];
          return ExpansionTile(
            leading: const Icon(Icons.history),
            title: Text(entry.term),
            subtitle: Text(
              'Buscado el ${entry.timestamp.day.toString().padLeft(2, '0')}/'
                  '${entry.timestamp.month.toString().padLeft(2, '0')}/'
                  '${entry.timestamp.year} a las '
                  '${entry.timestamp.hour.toString().padLeft(2, '0')}:'
                  '${entry.timestamp.minute.toString().padLeft(2, '0')}',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entry.results.map((r) => ListTile(
                    title: Text(r),
                    leading: const Icon(Icons.play_arrow),
                    onTap: () => _openFlashcardFromResult(r),
                  )).toList(),
                ),
              ),
              ButtonBar(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Eliminar esta entrada',
                    onPressed: () => _removeTermAt(index),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
