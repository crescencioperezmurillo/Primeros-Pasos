import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appsurgiflash/data/question_exam.dart';

class SavedExam {
  final DateTime dateTime;
  final List<Question> questions;
  final List<int?> selectedAnswers;

  SavedExam({
    required this.dateTime,
    required this.questions,
    required this.selectedAnswers,
  });

  String get formattedDate {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toJson() => {
    'dateTime': dateTime.toIso8601String(),
    'questions': questions.map((q) => q.toJson()).toList(),
    'selectedAnswers': selectedAnswers,
  };

  factory SavedExam.fromJson(Map<String, dynamic> json) => SavedExam(
    dateTime: DateTime.parse(json['dateTime']),
    questions: (json['questions'] as List)
        .map((q) => Question.fromJson(q))
        .toList(),
    selectedAnswers:
    (json['selectedAnswers'] as List).map((e) => e as int?).toList(),
  );
}

class SavedExamManager {
  static const _key = 'saved_exams';

  static Future<void> saveExam(SavedExam exam) async {
    final prefs = await SharedPreferences.getInstance();
    final exams = await getExams();
    exams.removeWhere((e) => e.dateTime == exam.dateTime);
    exams.add(exam);
    final encoded = jsonEncode(exams.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  static Future<void> removeExam(DateTime dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    final exams = await getExams();
    exams.removeWhere((e) => e.dateTime == dateTime);
    final encoded = jsonEncode(exams.map((e) => e.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  static Future<List<SavedExam>> getExams() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final decoded = jsonDecode(data);
    return (decoded as List)
        .map((e) => SavedExam.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<bool> isSaved(DateTime dateTime) async {
    final exams = await getExams();
    return exams.any((e) => e.dateTime == dateTime);
  }
}