import 'package:flutter/material.dart';
import 'saved_exam.dart';
import 'repaso_screen.dart'; // Este es ReviewScreen, asegúrate que coincida
import 'home_screen.dart';

class SavedExamsScreen extends StatefulWidget {
  const SavedExamsScreen({super.key});

  @override
  State<SavedExamsScreen> createState() => _SavedExamsScreenState();
}

class _SavedExamsScreenState extends State<SavedExamsScreen> {
  late Future<List<SavedExam>> _examsFuture;

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  void _loadExams() {
    _examsFuture = SavedExamManager.getExams();
  }

  Future<void> _deleteExam(DateTime dateTime) async {
    await SavedExamManager.removeExam(dateTime);
    setState(() {
      _loadExams(); // Recarga la lista tras eliminar
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Examen eliminado correctamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis exámenes'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: FutureBuilder<List<SavedExam>>(
        future: _examsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final exams = snapshot.data!;
          if (exams.isEmpty) return const Center(child: Text('No hay exámenes guardados.'));

          return ListView.builder(
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              return ListTile(
                title: Text('Examen ${index + 1}'),
                subtitle: Text(exam.formattedDate),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmar eliminación'),
                            content: const Text('¿Seguro que quieres eliminar este examen?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await _deleteExam(exam.dateTime);
                        }
                      },
                    ),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReviewScreen(
                        questions: exam.questions,
                        selectedAnswers: exam.selectedAnswers,
                        hideSaveButton: true, // 👈 Esto oculta el botón
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}