import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:appsurgiflash/data/question_exam.dart';
import '../start_screen/home_screen.dart';
import 'repaso_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  static const int totalTimeSeconds = 600;
  static const int totalQuestions = 10;

  late List<Question> _questions;
  late List<int?> _selectedAnswers;
  int _currentIndex = 0;
  int _score = 0;
  int _secondsLeft = totalTimeSeconds;
  Timer? _timer;
  bool _showInfo = true;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _questions = _pickRandomQuestions(allQuestions, totalQuestions);
  }

  List<Question> _pickRandomQuestions(List<Question> source, int count) {
    final random = Random();
    final copy = List<Question>.from(source)..shuffle(random);
    return copy.take(count).toList();
  }

  void _startExam() {
    setState(() {
      _showInfo = false;
      _currentIndex = 0;
      _score = 0;
      _secondsLeft = totalTimeSeconds;
      _isFinished = false;
      _selectedAnswers = List.filled(_questions.length, null);
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsLeft--;
        if (_secondsLeft <= 0) _finishExam();
      });
    });
  }

  void _answerQuestion(int selectedIndex) {
    _selectedAnswers[_currentIndex] = selectedIndex;
    if (_questions[_currentIndex].correctOptionIndex == selectedIndex) {
      _score++;
    }
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _finishExam();
    }
  }

  void _finishExam() {
    _timer?.cancel();
    setState(() {
      _isFinished = true;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<bool> _confirmExitToHome() async {
    _timer?.cancel();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Volver al menú principal?'),
        content: const Text('Perderás tu progreso actual. ¿Deseas salir al menú?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Sí, salir'),
          ),
        ],
      ),
    );
    return confirm == true;
  }

  Future<bool> _confirmExitExam() async {
    _timer?.cancel();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Salir del examen?'),
        content: const Text('Tu progreso se perderá. ¿Quieres salir al menú principal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Sí'),
          ),
        ],
      ),
    );
    return confirm == true;
  }

  Future<bool> _confirmBackToMenu() async {
    _timer?.cancel();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('¿Volver al menú?'),
            content: const Text(
                '¿Seguro que quieres volver al menú principal? Perderás tu puntuación actual.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Sí'),
              ),
            ],
          ),
    );
    return confirm == true;
  }

  void _resumeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsLeft--;
        if (_secondsLeft <= 0) _finishExam();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.white;
    final mainColor = Colors.green.shade400;
    final softButtonColor = Colors.green.shade200;
    final softTextColor = Colors.green.shade900;

    if (_showInfo) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('MODO EXAMEN', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
          centerTitle: true,
          backgroundColor: mainColor,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () async {
                final confirm = await _confirmExitToHome();
                if (confirm) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
                }
              },
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
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

            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/exam_info.png', height: 150),
                      const SizedBox(height: 20),
                      Text('Modo Examen', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green.shade800)),
                      const SizedBox(height: 16),
                      const Text(
                        'Responde 10 preguntas de opción múltiple en un tiempo máximo de 10 minutos.',
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: softButtonColor, foregroundColor: softTextColor,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _startExam,
                        child: const Text('¡Comenzar!', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (_isFinished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('RESULTADOS', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
          centerTitle: true,
          backgroundColor: mainColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('¿Volver a la pantalla de inicio?'),
                  content: const Text('Perderás la puntuación actual. ¿Quieres volver al inicio del examen?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Sí'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                setState(() {
                  _showInfo = true;
                  _isFinished = false;
                  _timer?.cancel();
                });
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () async {
                final exit = await _confirmExitToHome();
                if (exit) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
                }
              },
            ),
          ],
        ),

        backgroundColor: backgroundColor,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Tu puntuación es:', style: TextStyle(fontSize: 22, color: Colors.green.shade700)),
                const SizedBox(height: 12),
                Text('$_score / ${_questions.length}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ExamScreen())); },
                  style: ElevatedButton.styleFrom(backgroundColor: softButtonColor, foregroundColor: softTextColor, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Reintentar', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    final confirm = await _confirmBackToMenu();
                    if (confirm) {
                      _timer?.cancel();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: softButtonColor, foregroundColor: softTextColor, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Volver al menú', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewScreen(questions: _questions, selectedAnswers: _selectedAnswers)));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100, foregroundColor: Colors.blue.shade900, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Revisar respuestas', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('MODO EXAMEN: PREGUNTA ${_currentIndex + 1}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            final confirm = await _confirmExitExam();
            if (confirm) {
              setState(() {
                _showInfo = true;
                _timer?.cancel();
              });
            } else {
              _resumeTimer();
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () async {
              final exit = await _confirmExitToHome();
              if (exit) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
              } else {
                _resumeTimer();
              }
            },
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(color: Colors.white, width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/clock.png', height: 40),
              const SizedBox(width: 12),
              Text('Tiempo restante: ${_formatTime(_secondsLeft)}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
            ]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(question.text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 26, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 24),
                    ...List.generate(question.options.length, (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: softButtonColor, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => _answerQuestion(index),
                        child: Text(question.options[index], style: const TextStyle(fontSize: 20)),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}