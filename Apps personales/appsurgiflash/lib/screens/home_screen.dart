import 'package:flutter/material.dart';
import 'flashcards_screen.dart';
import 'search_screen.dart';
import 'info_screen.dart';
import 'exam_screen.dart';
import 'settings_screen.dart';
import 'drawers_action.dart';
import 'modo_kit_screen.dart';
import 'modo_docente_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<_MenuOption> _menuOptions = const [
    _MenuOption(
      icon: Icons.style,
      label: 'FLASHCARDS',
      description: 'Accede a las tarjetas de estudio de instrumental quirúrgico.',
      destinationScreen: FlashcardsScreen(),
    ),
    _MenuOption(
      icon: Icons.search,
      label: 'BUSCAR/EXPLORAR',
      description: 'Busca instrumental quirúrgico por nombre.',
      destinationScreen: SearchScreen(),
    ),
    _MenuOption(
      icon: Icons.info_outline,
      label: 'ENCICLOPEDIA QUIRÚRGICA',
      description: 'Información adicional sobre el instrumental y su uso en quirófano.',
      destinationScreen: InfoScreen(),
    ),
    _MenuOption(
      icon: Icons.quiz_outlined,
      label: 'MODO EXAMEN',
      description: 'Practica con preguntas tipo test para evaluar tus conocimientos.',
      destinationScreen: ExamScreen(),
    ),
    _MenuOption(
      icon: Icons.medical_services,
      label: 'MODO KIT',
      description: 'Explora los kits quirúrgicos organizados por procedimientos.',
      destinationScreen: ModoKitScreen(),
    ),
    _MenuOption(
      icon: Icons.school_outlined,
      label: 'MODO DOCENTE',
      description: 'Accede a recursos diseñados para la enseñanza quirúrgica.',
      destinationScreen: ModoDocenteScreen(),
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

  List<Widget> _buildDrawerOptions(BuildContext context) {
    return [
      Container(
        color: Colors.green.shade50,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/icons/icono_app.png',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'SURGIFLASH',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('Tu guía básica al mundo quirúrgico', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.bookmarks, color: Colors.black),
        title: const Text('Mis exámenes'),
        onTap: () {
          Navigator.pop(context);
          DrawerActions.showSavedExams(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings, color: Colors.black),
        title: const Text('Ajustes de la app'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.bookmark, color: Colors.black),
        title: const Text('Favoritos'),
        onTap: () {
          Navigator.pop(context);
          DrawerActions.showFavoritesInDevelopment(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.history, color: Colors.black),
        title: const Text('Historial de búsqueda'),
        onTap: () {
          Navigator.pop(context);
          DrawerActions.showSearchHistory(context);  // Aquí abrimos la pantalla historial
        },
      ),
      ListTile(
        leading: const Icon(Icons.info_outline, color: Colors.black),
        title: const Text('Sobre la app'),
        onTap: () {
          Navigator.pop(context);
          DrawerActions.showAboutDialog(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.contact_mail, color: Colors.black),
        title: const Text('Contacto'),
        onTap: () {
          Navigator.pop(context);
          DrawerActions.showContactDialog(context);
        },
      ),
    ];
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
          'MENÚ PRINCIPAL',
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
      ),
      drawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: _buildDrawerOptions(context)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(77),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/instrumental_banner.png',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bienvenido a la aplicación de estudio de instrumental quirúrgico. Tu herramienta clave para dominar los nombres, usos y formas de cada instrumento.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade100.withAlpha(77),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade100.withAlpha(77),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'CÓMO EMPEZAR',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Esta aplicación ha sido desarrollada con fines educativos. Mediante distintos recursos interactivos podrás reforzar tus conocimientos y practicar con confianza.',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: buttons.map((button) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: button,
                )).toList(),
              ),
              const SizedBox(height: 40),
              const Text(
                '© 2024 SURGIFLASH - Todos los derechos reservados',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
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

