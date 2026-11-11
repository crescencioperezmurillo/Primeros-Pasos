//EL SIGUIENTE PROGRAMA SE CORRESPONDE AL EJERCICIO PRACTICA DEL TEMA 6
// DEL MODULO DE FLUTTER DEL CAMPUS VIRTUAL

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curiosidades de la historia',
      theme: ThemeData.light(),
      home: Curiosidades (),
    );
  }
}

class Curiosidades extends StatelessWidget {
  const Curiosidades ({super.key});

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text ('Curiosidades de la historia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text (
                    'Curiosidad de hoy',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                       ),
                  ),
                  SizedBox(height:10.0),
                  Text (
                    'Los astronautas del Apolo 11 llegaron a la Luna en 1969,'
                        ' y lo hicieron con computadoras que tenían menor poder de procesamiento'
                        ' que una calculadora en la actualidad.',
                        style: TextStyle (
                      fontSize:16.0,
                  ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Es increibe el poder del ingenio humano.')),
                    );
                  },
                ),
                SizedBox(height:20.0),
                IconButton(
                  icon: Icon(Icons.thumb_down),
                  onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Vaya, siento mucho escuchar eso')),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height:20.0),
      ElevatedButton (
        onPressed: (){
          showDialog (
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text ('Más información del tema de hoy'),
                content: Text(
                  'La computadora usada solo tenia 64 Kb de memoria y pesaba 31 kilos'
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('cerrar'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Text(
            'Detalles curiosos',
        style: TextStyle(
            fontSize: 16.0,
        ),
      ),
      ),
      ],
        ),
      ),
    );
  }
}


