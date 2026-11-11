// PROGRAMA QUE CAMBIA LAS VOCALES POR EL CARACTER * EN UNA
// CADENA DE TEXTO.
// SE CORRESPONDE CON EL EJERCICIO 9 DEL CAMPUS VIRTUAL

import 'dart:io';

void main (){

  stdout.write('Introduzca una cadena de texto: ');
  String texto = stdin.readLineSync()!;

  String vocales ='aeiouAEIOU';

  String textofinal = '';

  for (int i=0; i<texto.length; i++) {
    if (vocales.contains(texto[i])) {
      textofinal += '*';
    }
    else {
      textofinal += texto [i];
    }
  }

  print ('$textofinal');

}