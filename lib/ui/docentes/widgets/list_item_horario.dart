import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class HorarioList extends StatelessWidget {
  final List<HorarioModel> horarios;
  const HorarioList({super.key, required this.horarios});

  // Mapa para convertir abreviaciones a nombres completos y para ordenar.
  static const Map<String, String> _nombresDias = {
    'LUN': 'Lunes',
    'MAR': 'Martes',
    'MIE': 'Miércoles',
    'JUE': 'Jueves',
    'VIE': 'Viernes',
    'SAB': 'Sábado',
    'DOM': 'Domingo',
  };

  @override
  Widget build(BuildContext context) {
    //Agrupa los horarios por día de la semana.
    final Map<String, List<HorarioModel>> horarioAgrupado = {};
    for (var horario in horarios) {
      final day = horario.diaSemana;
      if (horarioAgrupado[day] == null) {
        horarioAgrupado[day] = [];
      }
      horarioAgrupado[day]!.add(horario);
    }

    // Ordena los días para que aparezcan en el orden correcto
    final diasOrdenados = horarioAgrupado.keys.toList()
      ..sort((a, b) {
        final orden = ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB', 'DOM'];
        return orden.indexOf(a).compareTo(orden.indexOf(b));
      });

    return SliverList(
      delegate: SliverChildListDelegate([
        for (var diaKey in diasOrdenados) ...[
          _DiaSection(title: _nombresDias[diaKey] ?? diaKey),

          // La lista para este día se ordena por 'ini' antes de mapearse a widgets.
          ...(horarioAgrupado[diaKey]!..sort(
                (a, b) => a.ini.compareTo(b.ini),
              )) // Orden por hora de inicio
              .map((horario) => _HorarioItemCard(horario: horario)),

          const SizedBox(height: 16),
        ],
      ]),
    );
  }
}

// Widget privado para el encabezado del día
class _DiaSection extends StatelessWidget {
  final String title;
  const _DiaSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary.withAlpha(200),
        ),
      ),
    );
  }
}

class _HorarioItemCard extends StatelessWidget {
  final HorarioModel horario;
  const _HorarioItemCard({required this.horario});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.schedule, color: AppColors.secondary),
        title: Text(
          horario.materia,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          'Aula: ${horario.aula} | Grupo: ${horario.idGpo}\nHorario: ${horario.ini} - ${horario.fin}',
        ),
        isThreeLine: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
    );
  }
}
