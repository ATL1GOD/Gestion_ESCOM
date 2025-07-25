import 'package:flutter/material.dart';

class BecaInstitucional extends StatelessWidget {
  const BecaInstitucional({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //  Alinea el contenido a la izquierda
      children: [
         Center(
        child: Text(
          'Beca Institucional',
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
            ...['Ser alumno regular', 'Ser de 1er. a 8vo. semestre'].map((text) => Row(
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
        const SizedBox(height: 12.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Permite el scroll horizontal
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Promedio', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Monto', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('A')),
                  DataCell(Text('6.0 a 7.99')),
                  DataCell(Text('\$750.00')),
                ]),
                DataRow(cells: [
                  DataCell(Text('B')),
                  DataCell(Text('8.0 a 9.49')),
                  DataCell(Text('\$830.00')),
                ]),
                DataRow(cells: [
                  DataCell(Text('C')),
                  DataCell(Text('9.5 a 10')),
                  DataCell(Text('\$920.00')),
                ]),
              ],
            ),
          ),
        ],
      );
    }
  }
