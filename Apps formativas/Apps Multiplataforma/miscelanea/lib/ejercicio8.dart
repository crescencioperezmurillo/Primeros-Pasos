//PROGRAMA QUE DADA UNA LISTA DE NUMEROS ENTEROS SEPARA LOS
//IMPARES DE LA LISTA, MOSTRANDO EL RESULTADO EN LA CONSOLA.
//SE CORRESPONDE CON EL EJERCICIO 6 DEL CAMPUS VIRTUAL.

import 'dart:io';

void main (){

  stdout.write('¿Cúantos elementos tiene la lista? ');
  int elementos=int.parse(stdin.readLineSync()!);

  //Definimos las listas que vamos a utilizar
  List <int> numeros = [];
  List <int> impares = [];

  // Solicitamos los numero al usuario y añadimos a la lista
  for (int i=0; i< elementos; i++) {
    stdout.write('Ingrese un número: ');
    int enteros = int.parse(stdin.readLineSync()!);
    numeros.add(enteros);

    if (enteros % 2 != 0) {
    impares.add(enteros);
    }
  }

  // Imprimimos las dos listas
  print('La lista proporcionada por el usuario es: $numeros');
  print('Los números impares son: $impares');


}