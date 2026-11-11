import 'package:flutter/material.dart';
import '../modo_examen_screen/saved_exam.dart';
import '../modo_examen_screen/repaso_screen.dart'; // Este es ReviewScreen, asegúrate que coincida
import '../start_screen/home_screen.dart';

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
        title: const Text(
          'MIS EXÁMENES',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            letterSpacing: 1.1,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Título centrado
        backgroundColor: Colors.green[400],
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
      body: Column(
        children: [
          const SizedBox(height: 12), // espacio entre AppBar y Container
          // Bloque agregado con imagen y texto "¿Cómo funciona?"
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/kit_funciona.jpg',
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                const Text(
                  '¿Cómo funciona?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explora especialidades quirúrgicas y accede rápidamente a los instrumentos necesarios para cada tipo de intervención.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<SavedExam>>(
              future: _examsFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final exams = snapshot.data!;
                if (exams.isEmpty) {
                  return const Center(child: Text('No hay exámenes guardados.'));
                }

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
                            icon: const Icon(Icons.delete_forever, color: Colors.red),
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
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.black,
                                      ),
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.white),
                                      ),
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
                              hideSaveButton: true,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}