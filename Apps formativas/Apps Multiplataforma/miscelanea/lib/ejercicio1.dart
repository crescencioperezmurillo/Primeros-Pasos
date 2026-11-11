// PROGRAMA QUE PIDE TRES NÚMEROS AL USUARIO Y
// CALCULA SU MEDIA ARITMETICA.

import 'dart:io';

void main (){
  stdout.write('Ingrese el primer número: ');
  double num1 = double.parse(stdin.readLineSync()!);

  stdout.write('Ingrese el segundo número: ');
  double num2 = double.parse(stdin.readLineSync()!);

  stdout.write('Ingrese el tercer número: ');
  double num3 = double.parse(stdin.readLineSync()!);

  double media =(num1 + num2 + num3)/3;
  
  print('La media aritmética es: $media');

}