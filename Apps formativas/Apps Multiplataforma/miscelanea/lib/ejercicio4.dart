// PROGRAMA QUE ELIMINA LOS ELEMENTOS DUPLICADOS
// DE UNA LISTA Y LUEGO IMPRIME LA LISTA RESULTANTE

import 'dart:io';

void main(){
  List<int> numerosduplicados =[];
  List<int> numerossinduplicar = [];

  // Le pedimos al usuario el número de elementos
  // de la lista

  print ('Indique el número de elementos de la lista: ');
  int cantidad = int.parse(stdin.readLineSync()!);

  // añadir los numeros a la lista corresponciente
  for (int i=1; i<cantidad; i++) {
    stdout.write('Ingrese un número: ');
    int numero = int.parse(stdin.readLineSync()!);
    numerosduplicados.add(numero);

    // los numeros que se encuentran no repetidos son incluidos
    if (!numerossinduplicar.contains(numerosduplicados[i])){
      numerossinduplicar.add(numerosduplicados[i]);
    }
  }
  numerossinduplicar.sort();
  print ('La lista de numeros sin duplicar es: $numerossinduplicar');
}