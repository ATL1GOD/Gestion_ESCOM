import 'package:flutter/material.dart';

class DocenteDetailScreen extends StatelessWidget {
  final String numEmpleado;

  const DocenteDetailScreen({super.key, required this.numEmpleado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Docente: $numEmpleado')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Número de Empleado: $numEmpleado')],
        ),
      ),
    );
  }
}
