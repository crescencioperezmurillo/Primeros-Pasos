// PROGRAMA QUE INTERCAMBIA LAS MAYUSCULAS Y MINUSCULAS
// DE FORMA VICEVERSA EN UNA CADENA DE TEXTO
// SE CORRESPONDE CON EL EJERCICIO 8 DEL CAMPUS VIRTUAL

import 'dart:io';
void main (){

  stdout.write('Introduzca una cadena de texto: ');
  String texto = stdin.readLineSync()!;

  String textocambiado = '';

  for (int i=0; i<texto.length; i++){
    if(texto[i].toUpperCase()== texto[i]){
      textocambiado += texto[i].toLowerCase();
    }
    else{
      textocambiado += texto[i].toUpperCase();
    }
  }
print ('$textocambiado');
}