import 'package:flutter/material.dart';
import 'photo_screen.dart'; // Ajusta esta ruta según la ubicación real de tu archivo PhotoScreen.dart
import '../start_screen/home_screen.dart';  // Asegúrate de que esta ruta sea correcta

class ModoDocenteScreen extends StatefulWidget {
  const ModoDocenteScreen({super.key});

  @override
  State<ModoDocenteScreen> createState() => _ModoDocenteScreenState();
}

class _ModoDocenteScreenState extends State<ModoDocenteScreen> {
  final List<_MenuOption> _menuOptions = [
    _MenuOption(
      icon: Icons.camera_alt,
      label: 'FOTOGRAFÍA FLASH',
      description: 'Captura y estudia imágenes rápidas del instrumental quirúrgico',
      destinationScreen: const PhotoScreen(),
    ),
    _MenuOption(
      icon: Icons.description,
      label: 'Disposición del instrumental',
      description: 'Accede a mapas conceptuales sobre disposición del instrumental en la mesa quirúrgica en función de la cirugia',
      destinationScreen: const Placeholder(),
    ),
    _MenuOption(
      icon: Icons.note,
      label: 'ESQUEMAS Y NOTAS',
      description: 'Esquemas, notas y documentación para reforzar tus conocimientos',
      destinationScreen: const Placeholder(),
    ),
    _MenuOption(
      icon: Icons.warning,
      label: 'Las "perlas olvidadas" del profesor',
      description: 'Consejos básicos para afrontar el reto de instrumentar',
      destinationScreen: const Placeholder(),
    ),
  ];

  Widget _buildCircularButton(
      BuildContext context,
      IconData icon,
      String label,
      Widget destinationScreen,
      String description,
      ) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          content: Text(
            description,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.green[200],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => destinationScreen));
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.green.shade600,
                width: 3,
              ),
            ),
            child: Icon(icon, size: 64, color: Colors.green.shade600),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = _menuOptions.map((option) {
      return _buildCircularButton(
        context,
        option.icon,
        option.label,
        option.destinationScreen,
        option.description,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENÚ FLASHCARDS',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            tooltip: 'Home',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔁 Sección unificada estilo "¿Cómo funciona?"
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/foto_funciona.jpg',
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
                    'Explora las diferentes secciones para aprender, practicar y evaluar tus conocimientos con flashcards interactivas y ejercicios personalizados.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // 🔽 Botones circulares con scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: buttons.map((button) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: button,
                    )).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuOption {
  final IconData icon;
  final String label;
  final String description;
  final Widget destinationScreen;

  const _MenuOption({
    required this.icon,
    required this.label,
    required this.description,
    required this.destinationScreen,
  });
}