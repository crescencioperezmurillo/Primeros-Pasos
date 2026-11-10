import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'country_list.dart';
import 'vaccine_list.dart';
import 'requirements_screen.dart';  // Importamos la pantalla destino

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  String? selectedCountry;
  DateTime? travelDate;

  Map<String, Map<String, Map<String, String>>> datosVacunas = {};

  final List<String> checklistSanitario = [
    'Botiquín básico',
    'Repelente de insectos',
    'Protector solar',
    'Medicamentos recetados',
  ];

  final List<String> checklistDocumentacion = [
    'Tarjeta sanitaria',
    'Certificado de vacunación',
    'Seguro de viaje',
    'Recetas médicas',
  ];

  Map<String, bool> checklistSanitarioEstado = {};
  Map<String, bool> checklistDocumentacionEstado = {};

  @override
  void initState() {
    super.initState();
    _loadTravelData();
    _loadVaccineData();
    _loadChecklistData();
  }

  Future<void> _loadTravelData() async {
    final prefs = await SharedPreferences.getInstance();
    final country = prefs.getString('selectedCountryName');
    final dateString = prefs.getString('travelDate');
    DateTime? date;
    if (dateString != null) {
      date = DateTime.tryParse(dateString);
    }
    setState(() {
      selectedCountry = country;
      travelDate = date;
    });
  }

  Future<void> _loadVaccineData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('datosVacunas');
    if (jsonString != null) {
      setState(() {
        datosVacunas = Map<String, Map<String, Map<String, String>>>.from(
          (json.decode(jsonString) as Map).map((key, value) => MapEntry(
            key,
            Map<String, Map<String, String>>.from(
              (value as Map).map((k, v) => MapEntry(k, Map<String, String>.from(v))),
            ),
          )),
        );
      });
    }
  }

  Future<void> _saveVaccineData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('datosVacunas', json.encode(datosVacunas));
  }

  Future<void> _loadChecklistData() async {
    final prefs = await SharedPreferences.getInstance();
    final sanitario = prefs.getString('checklistSanitarioEstado');
    final documentacion = prefs.getString('checklistDocumentacionEstado');

    setState(() {
      checklistSanitarioEstado = sanitario != null
          ? Map<String, bool>.from(json.decode(sanitario))
          : {for (var item in checklistSanitario) item: false};

      checklistDocumentacionEstado = documentacion != null
          ? Map<String, bool>.from(json.decode(documentacion))
          : {for (var item in checklistDocumentacion) item: false};
    });
  }

  Future<void> _saveChecklistData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('checklistSanitarioEstado', json.encode(checklistSanitarioEstado));
    await prefs.setString('checklistDocumentacionEstado', json.encode(checklistDocumentacionEstado));
  }

  void _showVaccineDialog(String vacuna, String dosis) {
    final fechaController = TextEditingController();
    final loteController = TextEditingController();
    final lugarController = TextEditingController();

    if (datosVacunas[vacuna] != null && datosVacunas[vacuna]![dosis] != null) {
      final saved = datosVacunas[vacuna]![dosis]!;
      fechaController.text = saved['fecha'] ?? '';
      loteController.text = saved['lote'] ?? '';
      lugarController.text = saved['lugar'] ?? '';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Datos para $vacuna - Dosis $dosis'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: fechaController,
                  decoration: const InputDecoration(labelText: 'Fecha (DD/MM/AAAA)'),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: loteController,
                  decoration: const InputDecoration(labelText: 'Lote'),
                ),
                TextField(
                  controller: lugarController,
                  decoration: const InputDecoration(labelText: 'Lugar'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  datosVacunas[vacuna] ??= {};
                  datosVacunas[vacuna]![dosis] = {
                    'fecha': fechaController.text,
                    'lote': loteController.text,
                    'lugar': lugarController.text,
                  };
                });
                _saveVaccineData();
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _getVacunasRecomendadas() {
    if (selectedCountry == null) return [];
    final country = countries.firstWhere(
          (c) => c.name == selectedCountry,
      orElse: () => countries.first,
    );
    final vacunasStrings = country.vaccines.split(',').map((e) => e.trim()).toList();
    final recomendadas = vaccineList.where((vacuna) {
      return vacunasStrings.any((v) => v.toLowerCase() == vacuna['nombre'].toString().toLowerCase());
    }).toList();
    return recomendadas;
  }

  BoxDecoration _commonContainerDecoration() {
    return BoxDecoration(
      color: const Color(0xFF00BFA6),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF00BFA6), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
  }

  Widget _buildChecklist(String title, List<String> items, Map<String, bool> state,
      Function(bool?, String) onChanged) {
    final isEnabled = selectedCountry != null && travelDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleContainer(title),
        const SizedBox(height: 8),
        ...items.map((item) => CheckboxListTile(
          title: Text(item),
          value: state[item] ?? false,
          onChanged: (val) {
            if (!isEnabled) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Por favor, selecciona un país y fecha antes de modificar el checklist.'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }
            onChanged(val, item);
          },
        )),
      ],
    );
  }

  Widget _buildTitleContainer(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: _commonContainerDecoration(),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateText = travelDate != null
        ? '${travelDate!.day}/${travelDate!.month}/${travelDate!.year}'
        : 'No seleccionada';

    final vacunasRecomendadas = _getVacunasRecomendadas();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA6),
        title: const Text('MI SALUD',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleContainer('País de destino: ${selectedCountry ?? "No seleccionado"}'),
            const SizedBox(height: 8),
            _buildTitleContainer('Fecha de viaje: $dateText'),
            const SizedBox(height: 24),
            _buildTitleContainer('Vacunas recomendadas y dosis'),
            const SizedBox(height: 12),
            vacunasRecomendadas.isEmpty
                ? const Text('No hay vacunas recomendadas para este país.')
                : Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: const {
                0: FixedColumnWidth(180),
                1: FixedColumnWidth(60),
                2: FixedColumnWidth(40),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Vacuna', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Center(child: Text('Dosis', style: TextStyle(fontWeight: FontWeight.bold))),
                    Center(child: Text('Info', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                for (final vacuna in vacunasRecomendadas)
                  ...List.generate(int.parse(vacuna['dosis'].toString()), (index) {
                    final dosis = (index + 1).toString();
                    final hasInfo = datosVacunas[vacuna['nombre']]?[dosis] != null;
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: index == 0
                              ? Text(vacuna['nombre'])
                              : const SizedBox.shrink(),
                        ),
                        Center(child: Text(dosis)),
                        Center(
                          child: IconButton(
                            icon: Icon(
                              hasInfo ? Icons.check_circle : Icons.info_outline,
                              color: hasInfo ? Colors.green : Colors.grey,
                            ),
                            onPressed: () => _showVaccineDialog(vacuna['nombre'], dosis),
                          ),
                        ),
                      ],
                    );
                  }),
              ],
            ),
            const SizedBox(height: 24),
            _buildChecklist(
              'Checklist sanitario',
              checklistSanitario,
              checklistSanitarioEstado,
                  (val, item) {
                setState(() {
                  checklistSanitarioEstado[item] = val ?? false;
                });
                _saveChecklistData();
              },
            ),
            const SizedBox(height: 24),
            _buildChecklist(
              'Checklist documentación',
              checklistDocumentacion,
              checklistDocumentacionEstado,
                  (val, item) {
                setState(() {
                  checklistDocumentacionEstado[item] = val ?? false;
                });
                _saveChecklistData();
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('selectedCountryName');
                    await prefs.remove('travelDate');
                    await prefs.remove('datosVacunas');
                    await prefs.remove('checklistSanitarioEstado');
                    await prefs.remove('checklistDocumentacionEstado');

                    setState(() {
                      selectedCountry = null;
                      travelDate = null;
                      datosVacunas = {};
                      checklistSanitarioEstado = {for (var item in checklistSanitario) item: false};
                      checklistDocumentacionEstado = {for (var item in checklistDocumentacion) item: false};
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Text(
                      'BORRAR DATOS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    if (selectedCountry != null) {
                      await prefs.setString('selectedCountryName', selectedCountry!);
                    }
                    if (travelDate != null) {
                      await prefs.setString('travelDate', travelDate!.toIso8601String());
                    }

                    await prefs.setString('datosVacunas', json.encode(datosVacunas));
                    await prefs.setString('checklistSanitarioEstado', json.encode(checklistSanitarioEstado));
                    await prefs.setString('checklistDocumentacionEstado', json.encode(checklistDocumentacionEstado));

                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const RequirementsScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Text(
                      'GUARDAR Y TERMINAR VIAJE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}