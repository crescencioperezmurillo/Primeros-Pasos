import 'package:flutter/material.dart';
import 'package:appsurgiflash/data/question_exam.dart';
import 'saved_exam.dart';
import 'home_screen.dart'; // Importa tu pantalla home

class ReviewScreen extends StatefulWidget {
  final List<Question> questions;
  final List<int?> selectedAnswers;
  final bool hideSaveButton; // NUEVO parámetro

  const ReviewScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    this.hideSaveButton = false, // por defecto se muestra el botón
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late DateTime _examTime;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _examTime = DateTime.now();
    _checkSavedStatus();
  }

  Future<void> _checkSavedStatus() async {
    final saved = await SavedExamManager.isSaved(_examTime);
    setState(() => _isSaved = saved);
  }

  Future<void> _toggleSave() async {
    final exam = SavedExam(
      dateTime: _examTime,
      questions: widget.questions,
      selectedAnswers: widget.selectedAnswers,
    );

    if (_isSaved) {
      await SavedExamManager.removeExam(_examTime);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Examen eliminado')),
      );
    } else {
      await SavedExamManager.saveExam(exam);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Examen guardado')),
      );
    }

    _checkSavedStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisión de respuestas'),
        backgroundColor: Colors.green,
        actions: [
          if (!widget.hideSaveButton) // Solo muestra si está permitido
            IconButton(
              icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
              onPressed: _toggleSave,
              tooltip: _isSaved ? 'Eliminar examen' : 'Guardar examen',
            ),
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Inicio',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          final q = widget.questions[index];
          final selected = widget.selectedAnswers[index];
          final correct = q.correctOptionIndex;

          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pregunta ${index + 1}: ${q.text}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(q.options.length, (i) {
                    Color color;
                    if (i == correct) {
                      color = Colors.green;
                    } else if (i == selected) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        '${i + 1}. ${q.options[i]}',
                        style: TextStyle(color: color),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

