// PROGRAMA QUE IMPRIME LOS NUMEROS PARES DEL 2 AL 20 USANDO
// BUCLES WHILE
// CORRESPONDE AL EJERCICIO 4 DEL CAMPUS VIRTUAL

import 'dart:io';

void main(){

  int contador = 2; //Iniciamos el contador en dos, al ser el primer número par.
  int posicion = 1;


  while (contador <= 20) {

    print('El $posicionº numero par es $contador');
    contador += 2;
    posicion ++;

  }

}