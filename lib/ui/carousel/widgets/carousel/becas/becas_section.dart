import 'package:gestion_escom/ui/carousel/widgets/carousel/becas/becainstitucional.dart';
import 'package:gestion_escom/ui/carousel/widgets/carousel/becas/becastodas.dart';
import 'package:flutter/material.dart';

class BecasSection extends StatelessWidget {
  const BecasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, //  Alinea el contenido a la izquierda
      children: [
        Text(
          'Objetivo',
          style: TextStyle(
            fontSize: 24.0, // Ajusta el tamaño según lo que desees
            fontWeight:
                FontWeight.bold, // Puedes agregar negrita si lo prefieres
            color: Colors.black, // Cambia el color si es necesario
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Fijar estímulos dirigidos a la comunidad estudiantil, por medio de apoyos que contribuyan a reducir la deserción escolar y el incremento de la eficiencia terminal, para lograr la excelencia académica. En ESCOM puedes tener acceso a una gran variedad de becas, para ser acreedor de alguna de ellas debes estar atento a las convocatorias que se publican, donde encontrarás los procedimientos y documentos requeridos.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16.0),
        Text(
          'Datos de las becas disponibles',
          style: TextStyle(
            fontSize: 18.0, // Ajusta el tamaño según lo que desees
            fontWeight:
                FontWeight.bold, // Puedes agregar negrita si lo prefieres
            color: Colors.black, // Cambia el color si es necesario
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'El Instituto Politécnico Nacional de manera semestral hace del conocimiento público, por medio de los canales oficiales de comunucación, de la(s) convocatoria(s) correspondientes.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Text(
            'Tipos de becas',
            style: TextStyle(
              fontSize: 20.0, // Ajusta el tamaño según lo que desees
              fontWeight:
                  FontWeight.bold, // Puedes agregar negrita si lo prefieres
              color: Colors.black, // Cambia el color si es necesario
            ),
          ),
        ),
        const SizedBox(height: 18.0),

        const BecaInstitucional(),

        const SizedBox(height: 30.0),

        const BecaTodas(),

        const SizedBox(height: 30.0),
      ],
    );
  }
}
