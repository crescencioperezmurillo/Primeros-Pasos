// PROGRAMA QUE CALCULA EL FACTORIAL
// DE UN NUMERO ENTERO POSITIVO
// SE CORRESPONDE CON EL EJERCICIO 11 DEL CAMPUS VIRTUAL

import 'dart:io';

void main (){
  stdout.write('Introduzca el numero: ');
  int numero=int.parse(stdin.readLineSync()!);

  int factorial =1;
  int contador =1;

  while (contador <=numero){
    factorial *= contador;
    contador ++;
  }

  print('El factorial de $numero es $factorial');

}