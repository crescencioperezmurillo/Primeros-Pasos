class Question {
  final String text;
  final List<String> options;
  final int correctOptionIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });

  // Convierte el objeto Question a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }

  // Crea un objeto Question a partir de un mapa JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'] as int,
    );
  }
}

// Ejemplo de preguntas
final List<Question> allQuestions = [
  Question(
    text: '¿Cuál es la función principal del bisturí?',
    options: ['Cortar tejidos', 'Sujetar órganos', 'Coser heridas', 'Extraer fluidos'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Qué instrumento se utiliza para pinzar vasos sanguíneos?',
    options: ['Pinza de hemostasia', 'Tijeras', 'Portaagujas', 'Separador'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Cuál es el uso principal del separador?',
    options: ['Separar tejidos', 'Cortar huesos', 'Suturar', 'Extraer sangre'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Qué instrumento se usa para suturar?',
    options: ['Portaagujas', 'Bisturí', 'Pinza de hemostasia', 'Separador'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Para qué sirve la pinza de Kelly?',
    options: ['Sujetar tejidos', 'Cortar huesos', 'Extraer sangre', 'Separar músculos'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Qué instrumento es útil para cortar suturas?',
    options: ['Tijeras', 'Bisturí', 'Separador', 'Portaagujas'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Cuál es la función del aspirador quirúrgico?',
    options: ['Eliminar líquidos', 'Cortar tejidos', 'Sujetar órganos', 'Suturar heridas'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Qué instrumento se utiliza para explorar cavidades?',
    options: ['Sonda', 'Tijeras', 'Pinza de hemostasia', 'Bisturí'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Cuál es la característica principal del bisturí eléctrico?',
    options: ['Corta y coagula', 'Solo corta', 'Solo coagula', 'No se usa en cirugía'],
    correctOptionIndex: 0,
  ),
  Question(
    text: '¿Qué instrumento se usa para cortar huesos?',
    options: ['Sierra quirúrgica', 'Bisturí', 'Pinza de hemostasia', 'Tijeras'],
    correctOptionIndex: 0,
  ),
];