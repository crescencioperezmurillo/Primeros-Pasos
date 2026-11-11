// PROGRAMA QUE CALCULA LA TABLA DE MULTIPLICAR
// DE UN NUMERO PROPORCIONADO POR EL USUARIO

import 'dart:io';

void main (){

  stdout.write('Introduzca el número del cual quiere conocer su tabla de multiplicar: ');
  int numero=int.parse(stdin.readLineSync()!);


  for (int i=0; i<=10; i ++){
    int resultado = numero * i;
     print ('$numero x $i = $resultado');

    }
  }
