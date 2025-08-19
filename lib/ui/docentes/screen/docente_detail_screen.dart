import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:gestion_escom/ui/docentes/providers/docente_provider.dart';
import 'package:gestion_escom/ui/docentes/widgets/info_card.dart';
import 'package:gestion_escom/ui/docentes/widgets/list_item_horario.dart';

class DocenteDetailScreen extends ConsumerWidget {
  final String numEmpleado;
  const DocenteDetailScreen({super.key, required this.numEmpleado});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allDocentesAsync = ref.watch(allDocentesProvider);

    return Scaffold(
      body: allDocentesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error al obtener datos: $err')),
        data: (allDocentes) {
          DocenteModel? docente;
          try {
            docente = allDocentes.firstWhere(
              (d) => d.numEmpleado == numEmpleado,
            );
          } catch (e) {
            docente = null;
          }

          if (docente == null) {
            return const Center(
              child: Text('No se pudo encontrar la información del docente.'),
            );
          }

          // Si encontramos al docente, construimos el layout principal.
          return _buildLayout(context: context, docente: docente, ref: ref);
        },
      ),
    );
  }

  // Extraemos el layout principal para reutilizarlo
  Widget _buildLayout({
    required BuildContext context,
    required DocenteModel docente,
    required WidgetRef ref,
  }) {
    // Esto dispara la carga de horarios solo para este docente.
    final horariosAsync = ref.watch(
      horariosDocenteProvider(docente.numEmpleado),
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 340,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const _BackgroundHeader(),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                DocenteInfoCard(docente: docente),
              ],
            ),
          ),
        ),
        horariosAsync.when(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => SliverFillRemaining(
            child: Center(child: Text('Error al cargar horarios: $err')),
          ),
          data: (horarios) {
            if (horarios.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text("Este docente no tiene horarios asignados."),
                ),
              );
            }
            return HorarioList(horarios: horarios);
          },
        ),
      ],
    );
  }
}

class _BackgroundHeader extends StatelessWidget {
  const _BackgroundHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary, AppColors.textSecondary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
    );
  }
}
