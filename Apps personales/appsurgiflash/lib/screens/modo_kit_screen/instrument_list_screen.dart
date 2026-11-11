import 'package:flutter/material.dart';
import '../../data/instruments.dart';
import '../flashcards_screen/flashcards_screen.dart';
import '../start_screen/home_screen.dart';

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
        backgroundColor: Colors.green[400],
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: Colors.green, width: 1)),
        title: Text(
          'Instrumentos de $intervention',
          style: const TextStyle(
            fontSize: 24,
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
            final number = index + 1;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
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
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade300,
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
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                  ),
                ),
                trailing: Icon(Icons.chevron_right, color: Colors.green.shade700),
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