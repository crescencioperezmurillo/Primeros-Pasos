import 'package:flutter/material.dart';
import '../data/instruments.dart';
import 'flashcards_screen.dart';
import 'home_screen.dart'; // Importa tu pantalla Home

class InstrumentListScreen extends StatelessWidget {
  final String intervention;
  final List<String> instrumentIds;

  const InstrumentListScreen({
    super.key,
    required this.intervention,
    required this.instrumentIds,
  });

  Instrument? findInstrumentById(String id) {
    try {
      return instrumentsList.firstWhere((inst) => inst.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final instruments = instrumentIds
        .map((id) => findInstrumentById(id))
        .whereType<Instrument>()
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 0,
        // Back button automático
        title: Text(
          'Instrumentos de $intervention',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
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
        child: ListView.builder(
          itemCount: instruments.length,
          itemBuilder: (context, index) {
            final instrument = instruments[index];
            final number = index + 1; // numeración

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[300],
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Text(
                  instrument.name,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SingleFlashcardScreen(
                        instrument: instrument,
                        showFavoriteButton: true,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}