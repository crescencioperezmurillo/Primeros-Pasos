import 'package:flutter/material.dart';
import 'home_screen.dart';

// Importa las pantallas específicas
import 'info_screen/glosario_screen.dart';
import 'info_screen/fabricantes_screen.dart';
import 'info_screen/normativa_screen.dart';
import 'info_screen/referencias_screen.dart';
import 'info_screen/seguridad_screen.dart';
import 'info_screen/problemas_screen.dart';
import 'info_screen/formularios_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  void _navigate(BuildContext context, String route) {
    Widget screen;

    switch (route) {
      case '/glosario':
        screen = const GlosarioScreen();
        break;
      case '/fabricantes':
        screen = const FabricantesScreen();
        break;
      case '/normativa':
        screen = const NormativaScreen();
        break;
      case '/referencias':
        screen = const ReferenciasScreen();
        break;
      case '/seguridad':
        screen = const SeguridadScreen();
        break;
      case '/problemas':
        screen = const ProblemasScreen();
        break;
      case '/formularios':
        screen = const FormulariosScreen();
        break;
      default:
        screen = Scaffold(
          body: Center(child: Text('Pantalla no encontrada')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> sections = {
      'Información General': [
        {
          'title': 'Glosario de términos',
          'icon': Icons.book,
          'route': '/glosario',
          'description': 'Contiene definiciones clave utilizadas en el contexto del instrumental quirúrgico.',
        },
      ],
      'Apéndices': [
        {
          'title': 'Listado de fabricantes y proveedores',
          'icon': Icons.factory,
          'route': '/fabricantes',
          'description': 'Incluye un listado detallado de los principales fabricantes y proveedores de instrumental quirúrgico.',
        },
        {
          'title': 'Normativa internacional de calidad',
          'icon': Icons.rule,
          'route': '/normativa',
          'description': 'Describe los estándares internacionales de calidad aplicables al instrumental quirúrgico.',
        },
        {
          'title': 'Referencias bibliográficas',
          'icon': Icons.menu_book,
          'route': '/referencias',
          'description': 'Lista de fuentes bibliográficas utilizadas para la elaboración del contenido.',
        },
        {
          'title': 'Seguridad del paciente y del personal quirúrgico',
          'icon': Icons.security,
          'route': '/seguridad',
          'description': 'Medidas para proteger al paciente y al equipo quirúrgico durante el uso del instrumental.',
        },
        {
          'title': 'Problemas y soluciones en el instrumental quirúrgico',
          'icon': Icons.build,
          'route': '/problemas',
          'description': 'Guía para resolver problemas comunes asociados al instrumental quirúrgico.',
        },
        {
          'title': 'Formularios y checklist para control de instrumental',
          'icon': Icons.checklist,
          'route': '/formularios',
          'description': 'Herramientas para control y seguimiento del instrumental quirúrgico.',
        },
      ],
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        centerTitle: true,
        title: const Text(
          'Información',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
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
        child: ListView(
          children: [
            ...sections.entries.map((entry) {
              final category = entry.key;
              final items = entry.value;

              return ExpansionTile(
                tilePadding: EdgeInsets.zero,
                leading: Icon(
                  category == 'Apéndices' ? Icons.list_alt : Icons.info,
                  color: Colors.green,
                  size: 28,
                ),
                title: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                children: items.map((item) {
                  return ListTile(
                    leading: Icon(item['icon'], color: Colors.green),
                    title: Text(item['title'], style: const TextStyle(fontSize: 18)),
                    onTap: () => _navigate(context, item['route']),
                  );
                }).toList(),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}