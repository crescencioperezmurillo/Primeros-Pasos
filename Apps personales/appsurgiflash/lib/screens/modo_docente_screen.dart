import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModoDocenteScreen extends StatefulWidget {
  const ModoDocenteScreen({super.key});

  @override
  State<ModoDocenteScreen> createState() => _ModoDocenteScreenState();
}

class _ModoDocenteScreenState extends State<ModoDocenteScreen> {
  File? _selectedImage;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _usageController = TextEditingController();
  final _phaseController = TextEditingController();
  final _notesController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera); // O usa gallery
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

      // TODO: Guardar en base de datos o lista local
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Docente'),
        backgroundColor: Colors.green[700],
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