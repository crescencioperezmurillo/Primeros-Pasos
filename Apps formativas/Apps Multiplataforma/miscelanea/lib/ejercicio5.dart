// PROGRAMA QUE INDICA EL TIPO DE CLIMA EN FUNCIÓN
// DE LA TEMPERATURA AMBIENTE

import 'dart:io';

void main(){
  print ('Ingrese la temperatura en grados centigrados: ');
  double temperatura = double.parse (stdin.readLineSync()!);

  String clima;

  // Convertimos la temperatura en una categoría
  String categoria;

  if (temperatura <= 10) {
    categoria = 'frio';
  } else if (temperatura <= 20) {
    categoria = 'templado';
  } else if (temperatura <= 30) {
    categoria = 'tropical';
  } else {
    categoria = 'caluroso';
  }

  // Usamos switch para decidir el clima según la categoría
  switch (categoria) {
    case 'frio':
      clima = 'Clima frío';
      break;
    case 'templado':
      clima = 'Clima templado';
      break;
    case 'tropical':
      clima = 'Clima tropical';
      break;
    case 'caluroso':
      clima = 'Clima caluroso';
      break;
    default:
      clima = 'Categoría no definida';
  }

  print ('El tipo de clima actual es: $clima');
}