import 'package:flutter/material.dart';
import 'package:appsurgiflash/data/question_exam.dart';
import 'saved_exam.dart';
import '../start_screen/home_screen.dart'; // Importa tu pantalla home

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
        backgroundColor: Colors.green.shade400,
        centerTitle: true,  // Centra el título en Android y iOS
        title: const Text(
          'Revisión de respuestas',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        actions: [
          if (!widget.hideSaveButton)
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
                    Color textColor;
                    Color? backgroundColor;
                    Widget? icon;

                    if (i == correct && i == selected) {
                      // Correcta y seleccionada
                      textColor = Colors.white;
                      backgroundColor = Colors.green.shade300;
                      icon = const Icon(Icons.check_circle, color: Colors.white, size: 20);
                    } else if (i == correct) {
                      // Correcta no seleccionada
                      textColor = Colors.white;
                      backgroundColor = Colors.blue.shade200;
                      icon = const Icon(Icons.check, color: Colors.white, size: 16);
                    } else if (i == selected) {
                      // Seleccionada incorrecta
                      textColor = Colors.white;
                      backgroundColor = Colors.red.shade400;
                      icon = const Icon(Icons.cancel, color: Colors.white, size: 20);
                    } else {
                      // No seleccionada y no correcta
                      textColor = Colors.black;
                      backgroundColor = Colors.grey.shade200;
                      icon = null;
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          if (icon != null) icon,
                          if (icon != null) const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${i + 1}. ${q.options[i]}',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
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

