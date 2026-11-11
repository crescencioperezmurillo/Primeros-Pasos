import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SearchEntry {
  final String term;
  final List<String> results;
  final DateTime timestamp;

  SearchEntry({
    required this.term,
    required this.results,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'term': term,
      'results': results,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory SearchEntry.fromMap(Map<String, dynamic> map) {
    return SearchEntry(
      term: map['term'],
      results: List<String>.from(map['results']),
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class SearchHistory {
  static const _storageKey = 'search_history';

  static Future<List<SearchEntry>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((item) => SearchEntry.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> addSearchEntry(SearchEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    // Añadir nuevo término al principio (más reciente primero)
    history.insert(0, entry);

    // Guardar de nuevo en prefs
    final jsonString = json.encode(history.map((e) => e.toMap()).toList());
    await prefs.setString(_storageKey, jsonString);
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}