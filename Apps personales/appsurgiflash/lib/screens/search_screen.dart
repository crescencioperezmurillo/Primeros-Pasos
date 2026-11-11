// **************************************************************
// Nombre del archivo: search_screen.dart
// Proyecto: SurgiFlash
// Descripción: Pantalla que permite la búsqueda de instrumental
//              quirúrgico, usando el nombre parcial o total del instrumento.
//              El resultado de la búsqueda es una vista previa de la flashcard
//              del instrumento.
//
// Autor: Crescencio Pérez Murillo
// Fecha de creación: Abril-Julio 2025
// Última modificación: Julio 2025
//
// Derechos de autor © 2025 [Crescencio Pérez Murillo]
// Todos los derechos reservados.
//
// Esta aplicación está protegida por las leyes de derechos de autor y
// tratados internacionales. No se permite su copia, distribución o
// modificación sin el permiso explícito del autor.
//
// **************************************************************

// Importamos el framework de Flutter, la pantalla principal de la app
// para navegación Home, la lista de instrumentos quirúrgicos para poder realizar
// la búsqueda y la pantalla de flashcard para poder devolver los resultados de búsqueda.

import 'package:flutter/material.dart';
import 'package:appsurgiflash/data/instruments.dart';
import 'home_screen.dart';
import 'flashcards_screen.dart';
import 'search_history_screen.dart';
import 'search_history.dart'; // IMPORTA aquí la pantalla de historial

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Instrument> _filteredInstruments = [];
  String _lastSearchedTerm = '';

  void _filterResults(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredInstruments = [];
        _lastSearchedTerm = '';
      });
      return;
    }

    final results = instrumentsList.where((instrument) {
      final lowerQuery = query.toLowerCase();
      return instrument.name.toLowerCase().contains(lowerQuery);
    }).toList();

    setState(() {
      _filteredInstruments = results;
      _lastSearchedTerm = query;
    });
  }

  Future<void> _saveSearch() async {
    final term = _lastSearchedTerm.trim();
    if (term.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay término para guardar')),
      );
      return;
    }

    final results = _filteredInstruments.map((e) => e.name).toList();

    final entry = SearchEntry(
      term: term,
      results: results,
      timestamp: DateTime.now(),
    );

    await SearchHistory.addSearchEntry(entry);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Búsqueda guardada')),
    );
  }

  Future<void> _openFlashcard(Instrument instrument) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SingleFlashcardScreen(instrument: instrument),
      ),
    );
    // Al volver de la flashcard limpia el campo de búsqueda
    _controller.clear();
    _filterResults('');
  }

  void _goToSearchHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchHistoryScreen(fromSearchScreen: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BUSCAR INSTRUMENTO',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.green, width: 1)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            tooltip: 'Ver historial',
            onPressed: _goToSearchHistory,
          ),
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            tooltip: 'Guardar búsqueda',
            onPressed: _saveSearch,
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            tooltip: 'Menú Principal',
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
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _filterResults,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: 'Buscar instrumento',
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredInstruments.isEmpty
                  ? const Center(
                child: Text(
                  'No hay resultados',
                  style: TextStyle(color: Colors.black),
                ),
              )
                  : ListView.builder(
                itemCount: _filteredInstruments.length,
                itemBuilder: (context, index) {
                  final instrument = _filteredInstruments[index];
                  return Card(
                    child: ListTile(
                      title: Text(instrument.name),
                      onTap: () => _openFlashcard(instrument),
                    ),
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