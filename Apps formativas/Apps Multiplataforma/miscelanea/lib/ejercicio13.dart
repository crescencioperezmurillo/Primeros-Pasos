// PROGRAMA QUE RECORRE UNA CADENA DE TEXO E INDICA
// EL NUMERO DE VECES QUE APARECE UN DETERMINADO CARACTER
// SE CORRESPONDE CON EL EJERCICIO 10 DEL CAMPUS VIRTUAL

import 'dart:io';

void main (){
  stdout.write('Introduzca la cadena de texto: ');
  String texto = stdin.readLineSync()!;

  stdout.write ('introduzca el caracter a contar: ');
  String caracter = stdin.readLineSync()!;

  String textominusculas = texto.toLowerCase();
  String caracterminusculas = caracter.toLowerCase();

  int contador =0;

    for (int i=0; i< textominusculas.length; i++) {
      if (textominusculas[i] == caracterminusculas) {
        contador ++;
      }
    }

    print('El caracter $caracter aparece $contador veces');

}