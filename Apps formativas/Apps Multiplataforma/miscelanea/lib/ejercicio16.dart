// PROGRAMA QUE REALIZA UN TRIANGULO RECTANGULO
// USANDO EL CARACTER '*'

import 'dart:io';

void main (){

  stdout.write ('Introduzca la altura del triángulo : ');
  int altura =int.parse(stdin.readLineSync()!);

  for (int i=1; i<=altura; i++){
    var piso = '';
    for (int j=0; j<i; j ++){
     piso += '*';
    }
    print ('$piso');
  }

}