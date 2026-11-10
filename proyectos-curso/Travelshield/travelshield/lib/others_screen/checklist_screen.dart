/*
 * Checklist Screen - Pantalla de guardado de información sanitaria para el viaje de TravelShieldApp
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_screen/home_screen.dart';
import '../data/country_list.dart';
import '../data/vaccine_list.dart';
import 'history_screen.dart';

// Pantalla principal que permite gestionar el checklist y las vacunas
class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  // Variables que permiten almancer el pais y fecha seleccionada
  String? selectedCountry;
  DateTime? travelDate;
  // Datos de vacunas guardados: vacuna -> dosis -> información (fecha, lote, lugar)
  Map<String, Map<String, Map<String, String>>> datosVacunas = {};

  // Listas de ítems para los checklists sanitario y de documentación
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

  // Estado (marcado/no marcado) de cada ítem en los checklists
  Map<String, bool> checklistSanitarioEstado = {};
  Map<String, bool> checklistDocumentacionEstado = {};

  @override
  void initState() {
    super.initState();
    // Cargamos los datos guardados al iniciar la pantalla
    _loadTravelData();
    _loadVaccineData();
    _loadChecklistData();
  }

  // Cargamos país y fecha de viaje desde SharedPreferences
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

  // Cargamos  datos guardados de vacunas desde SharedPreferences y los convierte a Map
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

  // Guardamos los datos de vacunas en SharedPreferences como JSON
  Future<void> _saveVaccineData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('datosVacunas', json.encode(datosVacunas));
  }

  // Cargamos los estados de checklist sanitario y documentación desde SharedPreferences
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

  // Guardamos los estados de los checklists en SharedPreferences
  Future<void> _saveChecklistData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('checklistSanitarioEstado', json.encode(checklistSanitarioEstado));
    await prefs.setString('checklistDocumentacionEstado', json.encode(checklistDocumentacionEstado));
  }

  // Muestra diálogo para introducir datos de una dosis de vacuna (fecha, lote, lugar de administracion)
  void _showVaccineDialog(String vacuna, String dosis) {
    final fechaController = TextEditingController();
    final loteController = TextEditingController();
    final lugarController = TextEditingController();

    // Si ya hay datos guardados para esa vacuna y dosis, los carga en los campos
    if (datosVacunas[vacuna] != null && datosVacunas[vacuna]![dosis] != null) {
      final saved = datosVacunas[vacuna]![dosis]!;
      fechaController.text = saved['fecha'] ?? '';
      loteController.text = saved['lote'] ?? '';
      lugarController.text = saved['lugar'] ?? '';
    }

    // Construimos y mostramos el diálogo con campos para editar
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
                // Guardamos los datos introducidos en el estado y SharedPreferences
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

  // Obtenemos la lista de vacunas recomendadas para el país seleccionado
  List<Map<String, dynamic>> _getVacunasRecomendadas() {
    if (selectedCountry == null) return [];
    final country = countries.firstWhere(
          (c) => c.name == selectedCountry,
      orElse: () => countries.first,
    );
    // Dividimos el string de vacunas separadas por comas en lista y limpia espacios
    final vacunasStrings = country.vaccines.split(',').map((e) => e.trim()).toList();
    // Filtra la lista global de vacunas por las que están recomendadas para ese país
    final recomendadas = vaccineList.where((vacuna) {
      return vacunasStrings.any((v) => v.toLowerCase() == vacuna['nombre'].toString().toLowerCase());
    }).toList();
    return recomendadas;
  }

  // Estilo común para contenedores de títulos y secciones
  BoxDecoration _commonContainerDecoration() {
    return BoxDecoration(
      color: const Color(0xFF00BFA6),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF00BFA6), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: const Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
  }

  // Construimos una sección checklist con título, lista de ítems y callback para cambios
  Widget _buildChecklist(String title, List<String> items, Map<String, bool> state,
      Function(bool?, String) onChanged) {
    // Habilita interacción solo si hay país y fecha seleccionados
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
              // Si no hay país o fecha, muestra un mensaje de error
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

  // Construimos el contenedor para los títulos de las secciones
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
    // Texto que muestra la fecha seleccionada o un mensaje por defecto
    final dateText = travelDate != null
        ? '${travelDate!.day}/${travelDate!.month}/${travelDate!.year}'
        : 'No seleccionada';

    // Obtenemos las vacunas recomendadas para mostrar en la tabla
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
            // Mostramos el país seleccionado y fecha de viaje
            _buildTitleContainer('País de destino: ${selectedCountry ?? "No seleccionado"}'),
            const SizedBox(height: 8),
            _buildTitleContainer('Fecha de viaje: $dateText'),
            const SizedBox(height: 24),
            // Sección vacunas recomendadas con tabla
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
                // Fila de encabezados de la tabla
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
                // Para cada vacuna recomendada, generamos una fila por cada dosis
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
                            // Al pulsar, abrimos el diálogo para editar información de la dosis
                            onPressed: () => _showVaccineDialog(vacuna['nombre'], dosis),
                          ),
                        ),
                      ],
                    );
                  }),
              ],
            ),
            const SizedBox(height: 24),
            // Checklist sanitario con estados y manejo de cambios
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
            // Checklist documentación con estados y manejo de cambios
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
            // Botones para borrar datos o guardar y terminar viaje
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    // Limpiamos solo datos del viaje actual
                    await prefs.remove('selectedCountryName');
                    await prefs.remove('travelDate');
                    await prefs.remove('datosVacunas');
                    await prefs.remove('checklistSanitarioEstado');
                    await prefs.remove('checklistDocumentacionEstado');

                    // Reiniciamos el estado local de la pantalla a valores iniciales
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
                    // Validamos que haya país y fecha
                    if (selectedCountry == null || travelDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, selecciona un país y una fecha de viaje antes de guardar.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                    // Validamos que haya al menos una vacuna con datos completos (fecha, lote y lugar)
                    bool vacunaValida = false;
                    datosVacunas.forEach((vacuna, dosisMap) {
                      dosisMap.forEach((dosis, datos) {
                        if ((datos['fecha']?.isNotEmpty ?? false) &&
                            (datos['lote']?.isNotEmpty ?? false) &&
                            (datos['lugar']?.isNotEmpty ?? false)) {
                          vacunaValida = true;
                        }
                      });
                    });

                    // Validamos que haya al menos un checkbox marcado en alguno de los dos checklist
                    bool checklistMarcado = checklistSanitarioEstado.values.any((v) => v) ||
                        checklistDocumentacionEstado.values.any((v) => v);

                    if (!vacunaValida && !checklistMarcado) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Debes completar al menos una vacuna o marcar algún ítem del checklist antes de guardar.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }

                    final prefs = await SharedPreferences.getInstance();

                    final viajesJsonString = prefs.getString('listaViajes') ?? '[]';
                    List<dynamic> listaViajes = json.decode(viajesJsonString);

                    final viajeActual = {
                      'pais': selectedCountry,
                      'fecha': travelDate?.toIso8601String(),
                      'datosVacunas': datosVacunas,
                      'checklistSanitarioEstado': checklistSanitarioEstado,
                      'checklistDocumentacionEstado': checklistDocumentacionEstado,
                    };

                    listaViajes.add(viajeActual);
                    await prefs.setString('listaViajes', json.encode(listaViajes));

                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HistoryScreen()),
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