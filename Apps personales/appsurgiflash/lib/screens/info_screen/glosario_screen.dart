import 'package:flutter/material.dart';
import 'package:appsurgiflash/screens/start_screen/home_screen.dart'; // Asegúrate de que el path es correcto

// Asegúrate de importar o colocar tu clase Instrument e instrumentsList correctamente
import 'package:appsurgiflash/data/instruments.dart'; // o donde esté definida la clase + lista

class GlosarioScreen extends StatelessWidget {
  const GlosarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ordenar alfabéticamente por nombre
    final sortedList = [...instrumentsList]..sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Glosario de Instrumental'),
        backgroundColor: Colors.green[400],
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            tooltip: 'Inicio',
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
        padding: const EdgeInsets.all(12),
        color: const Color(0xFFF0F4F8),
        child: ListView.builder(
          itemCount: sortedList.length,
          itemBuilder: (context, index) {
            final instrument = sortedList[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    instrument.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  instrument.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('ID: ${instrument.id}'),
              ),
            );
          },
        ),
      ),
    );
  }
}