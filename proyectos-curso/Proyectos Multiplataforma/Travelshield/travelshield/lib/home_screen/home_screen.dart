/*
 * Home Screen - Pantalla principal de TravelShieldApp
 *
 * Derechos de autor © 2025 Crescencio Pérez Murillo.
 * Todos los derechos reservados.
 *
 * Uso y distribución:
 * Este código fuente y cualquier archivo asociado son propiedad exclusiva de Crescencio Pérez Murillo.
 * Queda prohibida la reproducción, distribución, modificación, o cualquier uso no autorizado
 * de este código sin la autorización previa y por escrito del titular de los derechos.
 *
 * Licencia:
 * El uso de este código está sujeto a los términos y condiciones establecidos por el titular.
 * Cualquier uso comercial o integración en proyectos derivados debe contar con la licencia adecuada.
 *
 * Exención de responsabilidad:
 * Este software se proporciona sin garantía de ningún tipo, expresa o implícita,
 * incluyendo pero no limitado a garantías de comerciabilidad o idoneidad para un propósito particular.
 *
 * Contacto:
 * Para consultas sobre licencias o permisos, por favor contactar a: contacto@travelshield.com
 */

import 'package:flutter/material.dart';
import '../others_screen/country_selection.dart';
import '../others_screen/history_screen.dart';
import '../others_screen/checklist_screen.dart';
import 'drawers.dart';

// Pantalla principal de la aplicación, sin estado (StatelessWidget)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos las pantallas que se mostrarán en el menú
    final List<_HomeOption> options = [
      _HomeOption(
        icon: Icons.public,
        label: 'Planifica tu viaje',
        description: 'Elige tu destino y protege tu salud',
        screen: const CountrySelectionScreen(),
      ),
      _HomeOption(
        icon: Icons.vaccines,
        label: 'Historial de viajes',
        description: 'Consulta viajes pasados y futuros',
        screen: const HistoryScreen(),
      ),
      _HomeOption(
        icon: Icons.health_and_safety,
        label: 'Mi salud',
        description: 'Gestiona tu información médica personal',
        screen: const ChecklistScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA6), // Color personalizado del AppBar
        centerTitle: true,
        title: const Text(
          'MENÚ PRINCIPAL',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const AppDrawer(), // Menú lateral desplegable
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Contenedor principal con imagen y texto de bienvenida
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.shade200,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen ubicada a la izquierda con proporción fija 4:3
                    Expanded(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.asset(
                            'assets/images/banners/banner_menu_principal.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Texto descriptivo a la derecha de la imagen
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              '¡Bienvenido a TravelShield!',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            '''TravelShield te acompaña en cada paso de tus viajes. Esta app te ofrece las mejores herramientas para planificar, controlar y asegurar tu salud desde el primer momento en el que decides organizar tu viaje. 
                            \nDesde elegir tu destino hasta cuidar tu salud en el camino, TravelShield, te permite disfrutar con tranquilidad sabiendo que toda la información y recursos sanitarios que necesitas están al alcance de tu mano.''',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Primera fila con dos botones grandes para las dos primeras opciones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: options.sublist(0, 2).map((option) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: LargeRoundButton(
                        icon: option.icon,
                        label: option.label,
                        description: option.description,
                        onTap: () {
                          // Navegación a la pantalla asociada cuando se toca el botón
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => option.screen),
                          );
                        },
                        large: true,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // Botón grande centrado para la tercera opción
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: LargeRoundButton(
                    icon: options[2].icon,
                    label: options[2].label,
                    description: options[2].description,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => options[2].screen),
                      );
                    },
                    large: true,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Texto de copyright al pie de la pantalla
              const Text(
                '© 2025 TravelShield. Todos los derechos reservados.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase que modela una opción del menú principal
class _HomeOption {
  final IconData icon;       // Icono representativo
  final String label;        // Título de la opción
  final String description;  // Descripción corta
  final Widget screen;       // Pantalla destino al pulsar la opción

  const _HomeOption({
    required this.icon,
    required this.label,
    required this.description,
    required this.screen,
  });
}

// Widget personalizado para un botón redondo grande con icono, texto y descripción
class LargeRoundButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap; // Función a ejecutar al pulsar
  final bool large;         // Controla tamaño del botón

  const LargeRoundButton({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    // Ajusta tamaño del icono y padding según si es grande o no
    final double iconSize = large ? 64 : 48;
    final double padding = large ? 32 : 24;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Contenedor circular con sombra y color personalizado
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF00BFA6),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
          const SizedBox(height: 12),
          // Texto del título
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          // Texto descriptivo del botón
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}