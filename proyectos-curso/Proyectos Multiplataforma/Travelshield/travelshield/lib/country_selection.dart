import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'country_list.dart';
import 'home_screen.dart';
import 'vaccine_list.dart';
import 'checklist_screen.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  String? selectedCountryName;
  DateTime? travelDate;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final countryName = prefs.getString('selectedCountryName');
    final dateString = prefs.getString('travelDate');

    DateTime? savedDate;
    if (dateString != null) {
      savedDate = DateTime.tryParse(dateString);
    }

    if (countryName != null || savedDate != null) {
      setState(() {
        selectedCountryName = countryName;
        travelDate = savedDate;
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (selectedCountryName != null && travelDate != null) {
      await prefs.setString('selectedCountryName', selectedCountryName!);
      await prefs.setString('travelDate', travelDate!.toIso8601String());

      if (!mounted) return;

      final shouldNavigate = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Datos guardados'),
          content: const Text('¿Deseas continuar al checklist de viaje?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );

      if (shouldNavigate == true && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ChecklistScreen(),
          ),
        );
      } else {
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
    final selectedCountry = selectedCountryName != null
        ? countries.firstWhere(
          (c) => c.name == selectedCountryName,
      orElse: () => countries[0],
    )
        : null;

    final now = DateTime.now();
    final daysUntilTravel =
    travelDate != null ? travelDate!.difference(now).inDays : 0;

    final calendarioVacunal = travelDate != null && selectedCountry != null
        ? vaccineList.where((vacuna) {
      return selectedCountry.vaccines.contains(vacuna['nombre']);
    }).map((vacuna) {
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
            Navigator.pop(context);
          },
          tooltip: 'Volver',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
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
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Selecciona el país de destino',
                  border: OutlineInputBorder(),
                ),
                value: selectedCountryName,
                items: countries.map((country) {
                  return DropdownMenuItem(
                    value: country.name,
                    child: Row(
                      children: [
                        Text(country.flag, style: const TextStyle(fontSize: 24)),
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
                  setState(() {
                    selectedCountryName = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: travelDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                  );
                  if (picked != null) {
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
                        : 'Selecciona una fecha',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                                selectedCountry.recommendations,
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
                          vacuna['estado'],
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          vacuna['nombre'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(vacuna['descripcion']),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 24),
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