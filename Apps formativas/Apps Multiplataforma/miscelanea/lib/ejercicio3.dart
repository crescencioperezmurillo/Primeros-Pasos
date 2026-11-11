// PROGRAMA EN EL QUE INICIALIZAMOS UNA LISTA
// Y SUMAMOS SUS ELEMENTOS.

import 'dart:io';

void main (){
  List<int> numeros =[];
  int suma = 0;

  // Le pedimos al usuario el número de elementos
  // de la lista

  print ('Indique el número de elementos de la lista: ');
  int cantidad = int.parse(stdin.readLineSync()!);

  for (int i=0; i<cantidad; i++){
    stdout.write('Ingrese un número: ');
    int numero = int.parse(stdin.readLineSync()!);
    numeros.add(numero);
    suma += numero;
  }
  print ('La suma de los números es: $suma');
}