// PROGRAMA QUE CALCULA LA MEDIA DE LAS CALIFICACIONES
// DE UN GRUPO DE ESTUDIANTES.
// SE CORRESPONDE CON EL EJERCICIO 12 DEL CAMPUS VIRTUAL

import 'dart:io';

void  main (){

  stdout.write ('Introduzca el numero total de estudiantes del grupo: ');
  int numeroestudiantes =int.parse(stdin.readLineSync()!);

  stdout.write ('Introduzca el numero de asignaturas totales: ');
  int numeroasignaturas =int.parse(stdin.readLineSync()!);

  Map<String, double> medias ={};

  for (int i= 1; i<= numeroestudiantes; i++){
    stdout.write ('Escribe el nombre del estudiante: ');
    String nombre = stdin.readLineSync()!;

    double sumanotas =0;

    for (int j=1; j<=numeroasignaturas; j++){
      stdout.write('Introduzca la nota correspondiente: ');
      double notafinal=double.parse(stdin.readLineSync()!);
      sumanotas += notafinal;
    }
    double media = sumanotas/numeroasignaturas;
    medias [nombre] = media;

  }

  medias.forEach((nombre, medias){
    String estado = medias >= 6.0? "Aprobó": "Suspendió";
    print("$nombre: Media = ${medias.toStringAsFixed(2)} - $estado");
  });
}
