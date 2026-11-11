// PROGRAMA QUE RECORRE UN MAPA DE NOMBRES Y EDADES Y POSTERIORMENTE
// LOS IMPRIME EN ORDEN ALFABÉTICO.
// SE CORRESPONDE CON EL EJERCICIO 3 DEL PROGRAMA VIRTUAL

import 'dart:io';

void main(){

  stdout.write('¿Cúantos elementos tiene la lista? ');
  int elementos=int.parse(stdin.readLineSync()!);

  Map<String, int> personas = {};

  for (int i=0; i<elementos; i++){
    stdout.write('Ingresa el nombre: ' );
    String nombre= stdin.readLineSync()!;

    stdout.write('Ingresa la edad de la persona: ' );
    int edad= int.parse (stdin.readLineSync()!);

    personas[nombre] = edad;
  }

  print('La lista ordenada de personas es:');

  List<MapEntry<String, int>> listaOrdenada = personas.entries.toList();
  listaOrdenada.sort((a, b) => a.key.compareTo(b.key));

    for (var entrada in listaOrdenada) {
    print("${entrada.key}: ${entrada.value} años");
  }
}