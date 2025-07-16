import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Un provider simple (lo moveremos luego a /providers)
final contadorProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contador = ref.watch(contadorProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Contador Riverpod")),
      body: Center(
        child: Text('Valor: $contador', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(contadorProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
