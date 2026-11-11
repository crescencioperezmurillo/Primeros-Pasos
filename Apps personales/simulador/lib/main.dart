import 'package:flutter/material.dart';
import 'world_map_screen.dart';

void main() {
  runApp(PoliticalSimApp());
}

class PoliticalSimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simulador Político",
      theme: ThemeData.dark(),
      home: WorldMapScreen(),
    );
  }
}