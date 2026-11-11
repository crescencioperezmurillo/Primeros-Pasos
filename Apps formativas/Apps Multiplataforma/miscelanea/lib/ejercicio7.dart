//PROGRAMA QUE DETERMINA SI UN NUMERO ES POSITIVO, NEGATIVO O CERO
// CORRESPONDE AL EJERCICIO 5 DEL CAMPUS VIRTUAL

import 'dart:io';

void main (){

  stdout.write('Ingrese un numero: ');
  double numero=double.parse(stdin.readLineSync()!);

  if (numero > 0) {
    print('El número $numero es positivo');
      }

  else if (numero < 0){
  print('El número $numero es negativo');
    }

  else {
  print('El número es cero');
    }
}