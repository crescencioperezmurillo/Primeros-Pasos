import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Asegúrate de importar la lista countries
import 'country_list.dart';

class RequirementsScreen extends StatefulWidget {
  const RequirementsScreen({super.key});

  @override
  State<RequirementsScreen> createState() => _RequirementsScreenState();
}

class _RequirementsScreenState extends State<RequirementsScreen> {
  String? selectedCountryName;
  DateTime? travelDate;

  Map<String, Map<String, Map<String, String>>> datosVacunas = {};
  Map<String, bool> checklistSanitarioEstado = {};
  Map<String, bool> checklistDocumentacionEstado = {};

  String? recomendacionesSanitarias;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      selectedCountryName = prefs.getString('selectedCountryName');
      final dateString = prefs.getString('travelDate');
      travelDate = dateString != null ? DateTime.tryParse(dateString) : null;

      final jsonVacunas = prefs.getString('datosVacunas');
      if (jsonVacunas != null) {
        datosVacunas = Map<String, Map<String, Map<String, String>>>.from(
          (json.decode(jsonVacunas) as Map).map((key, value) => MapEntry(
            key,
            Map<String, Map<String, String>>.from(
              (value as Map).map((k, v) => MapEntry(k, Map<String, String>.from(v))),
            ),
          )),
        );
      }

      final sanitario = prefs.getString('checklistSanitarioEstado');
      checklistSanitarioEstado = sanitario != null
          ? Map<String, bool>.from(json.decode(sanitario))
          : {};

      final documentacion = prefs.getString('checklistDocumentacionEstado');
      checklistDocumentacionEstado = documentacion != null
          ? Map<String, bool>.from(json.decode(documentacion))
          : {};

      // Obtener recomendaciones sanitarias desde la lista countries
      if (selectedCountryName != null) {
        final country = countries.firstWhere(
              (c) => c.name == selectedCountryName,
          orElse: () => Country(name: '', flag: '', recommendations: '', vaccines: ''),
        );
        recomendacionesSanitarias = country.recommendations;
      }
    });
  }

  Future<void> _printPdf() async {
    final pdf = pw.Document();

    final selectedCountry = selectedCountryName ?? 'No seleccionado';
    final countryFlag = countries.firstWhere(
          (c) => c.name == selectedCountryName,
      orElse: () => Country(name: '', flag: '', recommendations: '', vaccines: ''),
    ).flag;

    final dateText = travelDate != null
        ? '${travelDate!.day}/${travelDate!.month}/${travelDate!.year}'
        : 'No seleccionada';

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('Historial de viaje', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.Text('País de destino: $countryFlag $selectedCountry', style: pw.TextStyle(fontSize: 18)),
          pw.Text('Fecha de viaje: $dateText', style: pw.TextStyle(fontSize: 18)),
          pw.SizedBox(height: 16),
          pw.Text('Recomendaciones sanitarias:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text(recomendacionesSanitarias ?? 'No disponible'),
          pw.SizedBox(height: 16),
          pw.Text('Checklist Sanitario:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...checklistSanitarioEstado.entries.map((e) => pw.Text('${e.key}: ${e.value ? "✔️" : "❌"}')),
          pw.SizedBox(height: 16),
          pw.Text('Checklist Documentación:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...checklistDocumentacionEstado.entries.map((e) => pw.Text('${e.key}: ${e.value ? "✔️" : "❌"}')),
          pw.SizedBox(height: 16),
          pw.Text('Vacunas registradas:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          ...datosVacunas.entries.expand((vacunaEntry) {
            final vacuna = vacunaEntry.key;
            return vacunaEntry.value.entries.map((dosisEntry) {
              final dosis = dosisEntry.key;
              final info = dosisEntry.value;
              return pw.Text('$vacuna - Dosis $dosis: Fecha: ${info['fecha'] ?? ''}, Lote: ${info['lote'] ?? ''}, Lugar: ${info['lugar'] ?? ''}');
            });
          }),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateText = travelDate != null
        ? '${travelDate!.day}/${travelDate!.month}/${travelDate!.year}'
        : 'No seleccionada';

    final countryFlag = selectedCountryName != null
        ? countries.firstWhere(
          (c) => c.name == selectedCountryName,
      orElse: () => Country(name: '', flag: '', recommendations: '', vaccines: ''),
    ).flag
        : '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA6),
        title: const Text('HISTORIAL DE VIAJE',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Exportar PDF',
            onPressed: _printPdf,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text(
                'País de destino: $countryFlag ${selectedCountryName ?? "No seleccionado"}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ExpansionTile(
              title: Text(
                'Fecha de viaje: $dateText',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            if (recomendacionesSanitarias != null)
              ExpansionTile(
                title: const Text(
                  'Recomendaciones sanitarias',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(
                      recomendacionesSanitarias!,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ExpansionTile(
              title: const Text(
                'Checklist Sanitario',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              children: checklistSanitarioEstado.entries.map((e) {
                return ListTile(
                  leading: Icon(e.value ? Icons.check_box : Icons.check_box_outline_blank),
                  title: Text(e.key),
                );
              }).toList(),
            ),
            ExpansionTile(
              title: const Text(
                'Checklist Documentación',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              children: checklistDocumentacionEstado.entries.map((e) {
                return ListTile(
                  leading: Icon(e.value ? Icons.check_box : Icons.check_box_outline_blank),
                  title: Text(e.key),
                );
              }).toList(),
            ),
            ExpansionTile(
              title: const Text(
                'Vacunas registradas',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              children: datosVacunas.entries.expand((vacunaEntry) {
                final vacuna = vacunaEntry.key;
                return vacunaEntry.value.entries.map((dosisEntry) {
                  final dosis = dosisEntry.key;
                  final info = dosisEntry.value;
                  return ListTile(
                    title: Text('$vacuna - Dosis $dosis'),
                    subtitle: Text('Fecha: ${info['fecha'] ?? ''}, Lote: ${info['lote'] ?? ''}, Lugar: ${info['lugar'] ?? ''}'),
                  );
                });
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}