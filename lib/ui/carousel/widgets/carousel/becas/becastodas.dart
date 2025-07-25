import 'package:flutter/material.dart';

class BecaTodas extends StatelessWidget {
  const BecaTodas({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //  Alinea el contenido a la izquierda
      children: [
         Center(
        child: Text(
          'Beca TELMEX',
          style: TextStyle(
            fontSize: 17.0, // Ajusta el tamaño según lo que desees
            color: Colors.black, // Cambia el color si es necesario
          ),
        ),
        ),
        const SizedBox(height: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...['Ser alumno de 3er. a 8vo. semestre', 'Promedio mínimo de 8.5','Comprobante de actividad extra curricular','Monto: 1 salario mínimo mensual'].map((text) => Row(
              children: [
                const Icon(Icons.brightness_1, size: 8.0, color: Colors.black),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            )),
          ],
        ),
        const SizedBox(height: 20.0),
        Center(
        child: Text(
          'Beca Harp-Helú',
          style: TextStyle(
            fontSize: 17.0, // Ajusta el tamaño según lo que desees
            color: Colors.black, // Cambia el color si es necesario
          ),
        ),
        ),
        const SizedBox(height: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...['Ser alumno de 3er. a 8vo. semestre', 'Promedio mínimo de 8.0','Monto: \$1,000.00 mensuales'].map((text) => Row(
              children: [
                const Icon(Icons.brightness_1, size: 8.0, color: Colors.black),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            )),
          ],
        ),
        const SizedBox(height: 20.0),
        Center(
        child: Text(
          'Transporte',
          style: TextStyle(
            fontSize: 17.0, // Ajusta el tamaño según lo que desees
            color: Colors.black, // Cambia el color si es necesario
          ),
        ),
        ),
        const SizedBox(height: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...['Comprobar gastos de transporte de mínimo \$500.00 al mes', 'Monto: \$200 mensuales'].map((text) => Row(
              children: [
                const Icon(Icons.brightness_1, size: 8.0, color: Colors.black),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            )),
          ],
        ),
        ],
      );
    }
  }
