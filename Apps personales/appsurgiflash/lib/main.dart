import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/drawer_screen/favorites_provider.dart';
import 'screens/start_screen/warning_screen.dart'; // Asegúrate de que el archivo y clase existen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SurgiFlash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const WarningScreen(), // Aquí cargas la advertencia al inicio
    );
  }
}