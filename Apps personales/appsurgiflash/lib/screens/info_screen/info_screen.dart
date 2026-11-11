import 'package:flutter/material.dart';
import '../start_screen/home_screen.dart';

import 'glosario_screen.dart';
import 'fabricantes_screen.dart';
import 'normativa_screen.dart';
import 'referencias_screen.dart';
import 'seguridad_screen.dart';
import 'problemas_screen.dart';
import 'formularios_screen.dart';

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
        screen = const Scaffold(
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
          'ENCICLOPEDIA QUIRÚRGICA',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // 🔽 NUEVO BLOQUE INFORMATIVO CON IMAGEN
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
                    'assets/images/enciclopedia_info.jpg',
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
                    'Explora esta enciclopedia interactiva para consultar información clave, referencias, normativa y herramientas prácticas sobre instrumental quirúrgico.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 🔽 SECCIONES EXPANSIBLES
            ...sections.entries.map((entry) {
              final category = entry.key;
              final items = entry.value;

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
                      Icon(
                        category == 'Apéndices' ? Icons.list_alt : Icons.info,
                        color: Colors.black,
                        size: 28,
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
                children: items.map((item) {
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
                      leading: Icon(item['icon'], color: Colors.green.shade700),
                      title: Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () => _navigate(context, item['route']),
                    ),
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