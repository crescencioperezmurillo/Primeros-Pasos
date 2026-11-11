// PROGRAMA QUE DETERMINA SI UN NUMERO ENTERO POSITIVO
// ES PRIMO O NO
// SE CORRESPONDE CON EL EJERCICIO 7 DEL CAMPUS VIRTUAL

import 'dart:io';

void main(){

  int numero;
  bool primo = true;


  do {
    stdout.write('Introduzca el número a evaluar: ');
    numero = int.parse(stdin.readLineSync()!);

    if (numero <1){
      print ('Número no válido. Vuelva a introducir otro número: ');
    }
  }  while (numero <1);

  for (int i=2; i<=numero; i++){
  if (numero % i ==0) {
    primo = false;
    break;
      }
    }

  if (primo == false) {
    print('El número $numero no es primo');
  }
  else {
    print('El número $numero es primo');
  }
}