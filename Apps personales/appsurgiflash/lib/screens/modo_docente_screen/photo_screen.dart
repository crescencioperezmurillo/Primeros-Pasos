import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? _selectedImage;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _usageController = TextEditingController();
  final _phaseController = TextEditingController();
  final _notesController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _saveFlashcard() {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      final flashcard = {
        'imagePath': _selectedImage!.path,
        'name': _nameController.text,
        'specialty': _specialtyController.text,
        'usage': _usageController.text,
        'phase': _phaseController.text,
        'notes': _notesController.text,
      };

      print('Flashcard creada: $flashcard');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Flashcard guardada exitosamente')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _selectedImage = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos e incluye una imagen')),
      );
    }
  }

  Future<void> _exportFlashcardToPdf() async {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      final pdf = pw.Document();

      final image = pw.MemoryImage(_selectedImage!.readAsBytesSync());

      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(child: pw.Image(image, width: 200, height: 150)),
              pw.SizedBox(height: 12),
              pw.Text('Instrumento: ${_nameController.text}',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Text('Especialidad: ${_specialtyController.text}'),
              pw.Text('Usos clínicos: ${_usageController.text}'),
              pw.Text('Fase quirúrgica: ${_phaseController.text}'),
              if (_notesController.text.isNotEmpty)
                pw.Text('Notas: ${_notesController.text}'),
              pw.Divider(),
            ],
          ),
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos e incluye una imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Docente'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _exportFlashcardToPdf,
            tooltip: 'Exportar a PDF',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, height: 200)
                    : Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Tocar para tomar foto')),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre del instrumento'),
                validator: (value) => value!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _specialtyController,
                decoration: const InputDecoration(labelText: 'Especialidad'),
                validator: (value) => value!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _usageController,
                decoration: const InputDecoration(labelText: 'Usos clínicos'),
                validator: (value) => value!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _phaseController,
                decoration: const InputDecoration(labelText: 'Fase quirúrgica'),
                validator: (value) => value!.isEmpty ? 'Requerido' : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notas adicionales'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveFlashcard,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Flashcard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}