/*
 * CountrySelection Screen - Pantalla de selección de pais y fecha de viaje en TravelShieldApp
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
import 'package:shared_preferences/shared_preferences.dart';
import '../data/country_list.dart'; // Lista de países con datos asociados
import '../home_screen/home_screen.dart'; // Pantalla principal
import '../data/vaccine_list.dart'; // Lista de vacunas recomendadas
import 'checklist_screen.dart'; // Pantalla de checklist de viaje

// Widget principal para seleccionar el país y la fecha de viaje
class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  String? selectedCountryName; // País seleccionado por el usuario
  DateTime? travelDate; // Fecha de viaje seleccionada por el usuario

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Cargamos datos guardados al iniciar el widget
  }

  // Cargamos datos guardados en SharedPreferences (país y fecha)
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final countryName = prefs.getString('selectedCountryName');
    final dateString = prefs.getString('travelDate');

    DateTime? savedDate;
    if (dateString != null) {
      savedDate = DateTime.tryParse(dateString); // Convierte la cadena en DateTime
    }

    // Si hay datos guardados, actualizamos el estado para mostrarlos
    if (countryName != null || savedDate != null) {
      setState(() {
        selectedCountryName = countryName;
        travelDate = savedDate;
      });
    }
  }

  // Guardamos los datos seleccionados en SharedPreferences y mostramos un dialogo de confirmacion al usuario
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (selectedCountryName != null && travelDate != null) {
      // Guardamos país y fecha en preferencias
      await prefs.setString('selectedCountryName', selectedCountryName!);
      await prefs.setString('travelDate', travelDate!.toIso8601String());

      if (!mounted) return; // Verificamos que el widget sigue en pantalla

      // Mostramos un diálogo preguntando si deseamos ir al checklist de viaje (pantalla checlist_screen
      final bool? shouldNavigate = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Datos guardados'),
          content: const Text('¿Deseas continuar al checklist de viaje?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        ),
      );

      if (!mounted) return; // Comprobamos el estado tras el diálogo

      if (shouldNavigate == true) {
        // Navegamos a la pantalla checklist_screen  si el usuario aceptó
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ChecklistScreen(),
          ),
        );
      } else {
        // Mostramos un snackbar confirmando el guardado si no se quiere navegar a dicha pantalla
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Guardado: $selectedCountryName - Fecha: ${travelDate!.day}/${travelDate!.month}/${travelDate!.year}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Buscamos el objeto país seleccionado en la lista
    final selectedCountry = selectedCountryName != null
        ? countries.firstWhere(
          (c) => c.name == selectedCountryName,
      orElse: () => countries[0],
    )
        : null;

    final now = DateTime.now();
    // Calculamos los días restantes hasta la fecha de viaje
    final daysUntilTravel =
    travelDate != null ? travelDate!.difference(now).inDays : 0;

    // Creamos la lista de vacunas con estado según los días restantes hasta el viaje
    final calendarioVacunal = travelDate != null && selectedCountry != null
        ? vaccineList.where((vacuna) {
      // Filtramos vacunas requeridas por el país
      return selectedCountry.vaccines.contains(vacuna['nombre']);
    }).map((vacuna) {
      // Comprobarmos si el usuario está a tiempo o con retraso para administrarse la vacuna
      final ok = daysUntilTravel >= vacuna['diasMinimos'];
      return {
        'nombre': vacuna['nombre'],
        'estado': ok ? '✅ A tiempo' : '⚠️ Con retraso',
        'descripcion': vacuna['descripcion'],
      };
    }).toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA6),
        title: const Text(
          'PLANIFICA TU VIAJE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Botón para volver a la pantalla anterior
          },
          tooltip: 'Volver',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Navega a la pantalla principal y elimina el historial de navegación
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
              );
            },
            tooltip: 'Inicio',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Espacio alrededor del contenido
        child: SingleChildScrollView( // Permite scroll vertical si el contenido es largo
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown para seleccionar país de destino
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Selecciona el país de destino',
                  border: OutlineInputBorder(),
                ),
                value: selectedCountryName, // Valor actual seleccionado
                items: countries.map((country) {
                  return DropdownMenuItem(
                    value: country.name,
                    child: Row(
                      children: [
                        Text(country.flag, style: const TextStyle(fontSize: 24)), // Emoji bandera de los paises de la lista
                        const SizedBox(width: 8),
                        Text(
                          country.name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  // Actualiza el país seleccionado y refresca la UI
                  setState(() {
                    selectedCountryName = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Selector de fecha mediante tap
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: travelDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (picked != null) {
                    // Actualiza la fecha de viaje seleccionada
                    setState(() {
                      travelDate = picked;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fecha del viaje',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    travelDate != null
                        ? '${travelDate!.day}/${travelDate!.month}/${travelDate!.year}'
                        : 'Selecciona una fecha', // Texto indicativo cuando no hay fecha
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Mostramos recomendaciones y calendario sólo si hemos seleccionado país y fecha
              if (selectedCountry != null && travelDate != null) ...[
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/other_images/advertencia.png',
                    width: 40,
                    height: 40,
                  ),
                  title: const Text(
                    'Recomendaciones del país',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline,
                                color: Colors.orange, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                selectedCountry.recommendations, // Texto de recomendaciones
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ExpansionTile(
                  leading: Image.asset(
                    'assets/images/other_images/vacuna.jpg',
                    width: 40,
                    height: 40,
                  ),
                  title: const Text(
                    'Calendario vacunal sugerido',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  // Muestra la lista de vacunas con estado (a tiempo o retraso)
                  children: calendarioVacunal.map((vacuna) {
                    return Card(
                      color: vacuna['estado'].startsWith('⚠️')
                          ? Colors.red.shade50
                          : Colors.green.shade50,
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      child: ListTile(
                        leading: Text(
                          vacuna['estado'], // Indicador visual del estado
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          vacuna['nombre'], // Nombre de la vacuna
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(vacuna['descripcion']), // Descripción de la vacuna
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 24),
              // Botón para guardar los datos seleccionados
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar destino'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA6),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  // Solo habilita el botón si hemos seleccionado un país y fecha
                  onPressed: selectedCountryName != null && travelDate != null
                      ? _saveData
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}