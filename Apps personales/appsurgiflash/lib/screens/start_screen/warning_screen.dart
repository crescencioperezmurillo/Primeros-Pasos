import 'package:flutter/material.dart';
import '../start_screen/home_screen.dart';

class WarningScreen extends StatelessWidget {
  const WarningScreen({super.key}); // ✅ Constructor con key

  void continueToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black87,
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.all(24),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
const SizedBox(height: 20),

const Icon(
Icons.warning_amber_rounded,
size: 80,
color: Colors.yellow,
),

const SizedBox(height: 20),

const Text(
'ADVERTENCIA',
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.white,
fontSize: 36,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 20),

const Text(
'Esta aplicación técnica está destinada exclusivamente para '
'fines de capacitación profesional en el área de cirugía '
'e instrumentación quirúrgica. Su contenido ha sido diseñado '
'para servir como material de consulta en contextos educativos '
'y no constituye una guía clínica definitiva ni un protocolo '
'normativo oficial. Todos los procedimientos, técnicas y '
'descripciones instrumentales aquí presentados están basados '
'en prácticas estandarizadas de uso general en entornos '
'quirúrgicos.',
style: TextStyle(
color: Colors.white70,
fontSize: 18,
),
textAlign: TextAlign.justify,
),

const SizedBox(height: 20),

const Icon(
Icons.error_outline_rounded,
size: 50,
color: Colors.redAccent,
),

const SizedBox(height: 10),

const Text(
'IMPORTANTE: El uso, manipulación, limpieza, esterilización y '
'almacenamiento de los instrumentos quirúrgicos debe realizarse '
'conforme a los protocolos operativos normalizados (PON) del centro '
'asistencial correspondiente, así como a las recomendaciones de '
'los fabricantes. La aplicación incorrecta de los conceptos, técnicas '
'o materiales descritos en esta aplicación puede derivar en fallos '
'técnicos, contaminación cruzada, infecciones nosocomiales, lesiones '
'al paciente o al personal sanitario, así como en la pérdida de '
'funcionalidad de los instrumentos.',
style: TextStyle(
color: Colors.redAccent,
fontWeight: FontWeight.bold,
fontSize: 18,
),
textAlign: TextAlign.justify,
),

const SizedBox(height: 30),

SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () => continueToHome(context),
child: const Padding(
padding: EdgeInsets.symmetric(vertical: 14),
child: Text(
'Aceptar y continuar',
style: TextStyle(fontSize: 18),
),
),
),
),

const SizedBox(height: 20),
],
),
),
),
);
}
}