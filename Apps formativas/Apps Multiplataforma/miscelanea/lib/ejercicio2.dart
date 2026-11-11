// PROGRAMA QUE DADO UN NÚMERO
// NOS INDICA SI ES PAR O IMPAR.

import 'dart:io';

void main (){
  stdout.write('Ingrese el número: ');
  int numero = int.parse(stdin.readLineSync()!);

  // los numero pares son aquellos que al dividirlos entre
  // dos su resto es cero.

  if ( numero % 2 == 0){
    print ('El $numero es par ');
  }
  else {
    print ('El $numero es impar ');
  }
}