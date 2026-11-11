import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class WorldMapScreen extends StatefulWidget {
  @override
  _WorldMapScreenState createState() => _WorldMapScreenState();
}

class _WorldMapScreenState extends State<WorldMapScreen> {
  int selectedIndex = -1; // Inicializamos sin selección
  late MapShapeSource dataSource;

  @override
  void initState() {
    super.initState();
    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "name", // Campo del GeoJSON con nombre de país
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa Político Mundial")),
      body: SfMaps(
        layers: [
          MapShapeLayer(
            source: dataSource,
            strokeColor: Colors.black,
            strokeWidth: 0.3,
            selectedIndex: selectedIndex >= 0 ? selectedIndex : 0, // Evita null
            selectionSettings: const MapSelectionSettings(
              color: Colors.blueAccent,
              strokeColor: Colors.white,
              strokeWidth: 1.5,
            ),
            onSelectionChanged: (int index) {
              setState(() {
                selectedIndex = index;
              });
              final countryName = dataSource.primaryValueMapper!(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Seleccionaste: $countryName"),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}