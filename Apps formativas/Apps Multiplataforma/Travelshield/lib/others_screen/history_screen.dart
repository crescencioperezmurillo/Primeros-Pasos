/*
 * History Screen - Pantalla de historial de viajes en TravelShieldApp
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
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../data/country_list.dart';

// Pantalla que muestra el historial de viajes registrados por el usuario.
//
// Permite seleccionar un país para visualizar los detalles del viaje,
// incluyendo fecha, recomendaciones sanitarias, checklists y vacunas.
// También permite exportar esta información en formato PDF.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen ({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Lista que almacena los viajes guardados, cada uno con su información
  List<Map<String, dynamic>> listaViajes = [];

  // País seleccionado actualmente para mostrar detalles o exportar datos
  String? paisSeleccionado;

  @override
  void initState() {
    super.initState();
    _loadAllData(); // Cargamos datos guardados al iniciar pantalla
  }

  // Cargamos la lista de viajes almacenada en SharedPreferences
  // y actualizamos el estado con la información recuperada.
  Future<void> _loadAllData() async {
    final prefs = await SharedPreferences.getInstance();

    // Obtenemos la lista de viajes en formato JSON, si no existe devolver lista vacía
    final viajesJsonString = prefs.getString('listaViajes') ?? '[]';

    // Decodificamos el JSON a una lista dinámica
    final viajesDecoded = json.decode(viajesJsonString) as List<dynamic>;

    setState(() {
      // Convertimos a lista de mapas con datos de cada viaje
      listaViajes = viajesDecoded.cast<Map<String, dynamic>>();

      // Establecemos el país seleccionado en el primero de la lista
      if (listaViajes.isNotEmpty) {
        final firstPais = listaViajes.first['pais'];
        if (firstPais is String && firstPais.isNotEmpty) {
          paisSeleccionado = firstPais;
        } else {
          paisSeleccionado = null;
        }
      }
    });
  }

  // Genera y muestra un PDF con los detalles del viaje al país seleccionado.
  Future<void> _printPdf(String pais) async {
    final pdf = pw.Document();

    // Buscamos el viaje que corresponde al país seleccionado
    final viaje = listaViajes.firstWhere(
          (v) => v['pais'] == pais,
      orElse: () => <String, dynamic>{},
    );

    if (viaje.isEmpty) {
      // Mostramos un mensaje si no se encontramos ningún viaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró el viaje seleccionado.')),
      );
      return;
    }

    // Buscamos información del país para mostrar recomendaciones, bandera y otros datos
    final countryObj = countries.firstWhere(
          (c) => c.name == pais,
      orElse: () =>
      const Country(name: '', flag: '', recommendations: '', vaccines: ''),
    );

    // La fecha se muestra en formato día/mes/año
    final fechaStr = viaje['fecha'];
    final fecha = (fechaStr is String) ? DateTime.tryParse(fechaStr) : null;
    final dateText = fecha != null
        ? '${fecha.day}/${fecha.month}/${fecha.year}'
        : 'No seleccionada';

    // Obtenemos las recomendaciones sanitarias del país. Si no hay, devuelve un mensaje de no disponible
    final recomendacionesSanitarias = countryObj.recommendations
        .trim()
        .isEmpty
        ? 'No disponible'
        : countryObj.recommendations;

    // Extraer datos de vacunas, checklist sanitario y documentación del viaje
    final datosVacunasViaje = viaje['datosVacunas'] is Map<String, dynamic>
        ? viaje['datosVacunas'] as Map<String, dynamic>
        : <String, dynamic>{};

    final checklistSanitarioViaje = viaje['checklistSanitarioEstado'] is Map<
        String,
        dynamic>
        ? viaje['checklistSanitarioEstado'] as Map<String, dynamic>
        : <String, dynamic>{};

    final checklistDocumentacionViaje = viaje['checklistDocumentacionEstado'] is Map<
        String,
        dynamic>
        ? viaje['checklistDocumentacionEstado'] as Map<String, dynamic>
        : <String, dynamic>{};

    // Realizamos la construcción del contenido del PDF
    pdf.addPage(
      pw.MultiPage(
        build: (context) =>
        [
          pw.Text('Historial de viaje', style: pw.TextStyle(
              fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.Text('País de destino: $pais', style: pw.TextStyle(fontSize: 18)),
          pw.Text(
              'Fecha de viaje: $dateText', style: pw.TextStyle(fontSize: 18)),
          pw.SizedBox(height: 16),
          pw.Text('Recomendaciones sanitarias:', style: pw.TextStyle(
              fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text(recomendacionesSanitarias),
          pw.SizedBox(height: 16),
          pw.Text('Checklist Sanitario:', style: pw.TextStyle(
              fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...checklistSanitarioViaje.entries.map((e) =>
              pw.Text('${e.key}: ${e.value ? "Sí" : "No"}')),
          pw.SizedBox(height: 16),
          pw.Text('Checklist Documentación:', style: pw.TextStyle(
              fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...checklistDocumentacionViaje.entries.map((e) =>
              pw.Text('${e.key}: ${e.value ? "Sí" : "No"}')),
          pw.SizedBox(height: 16),
          pw.Text('Vacunas registradas:', style: pw.TextStyle(
              fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...datosVacunasViaje.entries.expand((vacunaEntry) {
            final vacuna = vacunaEntry.key;
            final dosisMap = vacunaEntry.value as Map<String, dynamic>;
            return dosisMap.entries.map((dosisEntry) {
              final dosis = dosisEntry.key;
              final info = dosisEntry.value as Map<String, dynamic>;
              return pw.Text('$vacuna - Dosis $dosis: Fecha: ${info['fecha'] ??
                  ''}, Lote: ${info['lote'] ?? ''}, Lugar: ${info['lugar'] ??
                  ''}');
            });
          }),
        ],
      ),
    );

    // Mostramos el diálogo para imprimir o guardar el PDF generado
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Creamos una lista única de países de los viajes registrados
    final paises = listaViajes
        .map((v) => v['pais'])
        .whereType<String>()
        .toSet()
        .toList();

    // Aseguramos que el valor seleccionado está en la lista actualizada
    String? dropdownValue = paisSeleccionado;
    if (dropdownValue != null && !paises.contains(dropdownValue)) {
      dropdownValue = null;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA6),
        title: const Text(
          'HISTORIAL DE VIAJES',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Exportar PDF',
            onPressed: () {
              if (dropdownValue != null) {
                // Si hay un país seleccionado, generamos e imprimimos el PDF con los datos del viaje
                _printPdf(dropdownValue);
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              'Seleccione el país para imprimir:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: dropdownValue,
              items: paises.map((pais) {
                return DropdownMenuItem<String>(
                  value: pais,
                  child: Text(pais),
                );
              }).toList(),
              onChanged: (value) {
                // Actualizamos el país seleccionado cuando el usuario cambia el dropdown
                setState(() {
                  paisSeleccionado = value;
                });
              },
              hint: const Text('Seleccione un país'),
              isExpanded: true,
            ),
          ),
          Expanded(
            child: listaViajes.isEmpty
                ? const Center(child: Text(
                'No hay viajes registrados.')) // Mostamos un Mensaje cuando no hay datos
                : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listaViajes.length,
              itemBuilder: (context, index) {
                final viaje = listaViajes[index];
                final pais = viaje['pais'] is String
                    ? viaje['pais']
                    : 'No seleccionado';
                final fechaStr = viaje['fecha'];
                final fecha = (fechaStr is String)
                    ? DateTime.tryParse(fechaStr)
                    : null;
                final dateText = fecha != null ? '${fecha.day}/${fecha
                    .month}/${fecha.year}' : 'No seleccionada';

                // Obtienemos los datos de vacunas y checklists del viaje, asegurando que sean mapas
                final datosVacunasViaje = viaje['datosVacunas'] is Map<
                    String,
                    dynamic>
                    ? viaje['datosVacunas'] as Map<String, dynamic>
                    : <String, dynamic>{};
                final checklistSanitarioViaje = viaje['checklistSanitarioEstado'] is Map<
                    String,
                    dynamic>
                    ? viaje['checklistSanitarioEstado'] as Map<String, dynamic>
                    : <String, dynamic>{};
                final checklistDocumentacionViaje = viaje['checklistDocumentacionEstado'] is Map<
                    String,
                    dynamic>
                    ? viaje['checklistDocumentacionEstado'] as Map<
                    String,
                    dynamic>
                    : <String, dynamic>{};

                // Buscamos el objeto Country para mostrar datos adicionales como la bandera y recomendaciones
                final countryObj = countries.firstWhere(
                      (c) => c.name == pais,
                  orElse: () =>
                  const Country(
                      name: '', flag: '', recommendations: '', vaccines: ''),
                );

                final recomendacionesSanitarias = countryObj.recommendations
                    .trim()
                    .isEmpty
                    ? 'No disponible'
                    : countryObj.recommendations;

                return ExpansionTile(
                  // Título del viaje con bandera y nombre del país
                  title: Text(
                    '${countryObj.flag} $pais',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text('Fecha: $dateText'),
                  childrenPadding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 8),
                  children: [
                    // Expansión para mostrar las recomendaciones sanitarias
                    ExpansionTile(
                      title: const Text('Recomendaciones sanitarias',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recomendacionesSanitarias,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                    // Expansión para mostrar el checklist sanitario
                    ExpansionTile(
                      title: const Text('Checklist Sanitario',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      children: checklistSanitarioViaje.entries
                          .map((e) =>
                          ListTile(
                            title: Text('${e.key}: ${e.value ? "Sí" : "No"}'),
                          ))
                          .toList(),
                    ),
                    // Expansión para mostrar el checklist de documentación sanitaria
                    ExpansionTile(
                      title: const Text('Checklist Documentación',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      children: checklistDocumentacionViaje.entries
                          .map((e) =>
                          ListTile(
                            title: Text('${e.key}: ${e.value ? "Sí" : "No"}'),
                          ))
                          .toList(),
                    ),
                    // Expansión para mostrar las vacunas registradas con detalles de cada dosis
                    ExpansionTile(
                      title: const Text('Vacunas registradas',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      children: datosVacunasViaje.entries.expand((vacunaEntry) {
                        final vacuna = vacunaEntry.key;
                        final dosisMap = vacunaEntry.value as Map<
                            String,
                            dynamic>;
                        return dosisMap.entries.map((dosisEntry) {
                          final dosis = dosisEntry.key;
                          final info = dosisEntry.value as Map<String, dynamic>;
                          return ListTile(
                            title: Text(
                              '$vacuna - Dosis $dosis: Fecha: ${info['fecha'] ??
                                  ''}, Lote: ${info['lote'] ??
                                  ''}, Lugar: ${info['lugar'] ?? ''}',
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}