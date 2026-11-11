//PROGRAMA BÁSICO EN FLUTTER QUE USA
//'PROVIDER' PARA MANEJAR EL ESTADO DE UN CONTADOR

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp (
    ChangeNotifierProvider (
    create: (_) => Counter (),
    child: const Myapp(),
  )
  );

}

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value ++;
    notifyListeners();
  }
}

class Myapp extends StatelessWidget {
  const Myapp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  home: Scaffold (
    appBar: AppBar(title: const Text('Contador básico usando provider')),
    body: Center (
      child: Consumer <Counter>(
      builder: (_, counter, __) => Text(
        '${counter.value}',
      style: const TextStyle (fontSize: 50),
    ),

  ),

  ),

    floatingActionButton: FloatingActionButton(
  onPressed: () => context.read<Counter>().increment(),
    child: const Icon(Icons.add),
  ),

    ),
    );
  }
}