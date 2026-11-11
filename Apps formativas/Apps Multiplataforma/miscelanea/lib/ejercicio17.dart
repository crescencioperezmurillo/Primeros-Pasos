// PROGRAMA QUE IMPRIME LA SUCESION DE FIBONACCI

import 'dart:io';

void main (){

  stdout.write ('Introduzca el número de terminos que quieres generar: ');
  int numero =int.parse(stdin.readLineSync()!);

  var fibonaci=0;
  var variable_auxiliar=1;

  for (int i=0; i<numero; i++) {
    print ('$fibonaci');
    variable_auxiliar += fibonaci;
    fibonaci =variable_auxiliar - fibonaci;
  }
}