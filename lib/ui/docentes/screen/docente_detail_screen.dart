import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:gestion_escom/ui/docentes/providers/docente_provider.dart';
import 'package:gestion_escom/ui/docentes/widgets/info_card.dart';
import 'package:gestion_escom/ui/docentes/widgets/list_item_horario.dart';

class DocenteDetailScreen extends ConsumerStatefulWidget {
  final String numEmpleado;
  const DocenteDetailScreen({super.key, required this.numEmpleado});

  @override
  ConsumerState<DocenteDetailScreen> createState() =>
      _DocenteDetailScreenState();
}

class _DocenteDetailScreenState extends ConsumerState<DocenteDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(docenteProvider.notifier).cargarHorarios(widget.numEmpleado);
    });
  }

  @override
  Widget build(BuildContext context) {
    final docenteState = ref.watch(docenteProvider);

    return Scaffold(
      // Mantenemos el fondo del scaffold si es necesario, o lo dejamos por defecto
      // backgroundColor: Colors.grey[100],
      body: docenteState.isLoading && docenteState.horarios.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context, docenteState),
    );
  }

  // Widget para construir el contenido una vez que la carga ha terminado
  Widget _buildContent(BuildContext context, DocenteProvider docenteState) {
    DocenteModel? docente;
    try {
      docente = docenteState.docentes.firstWhere(
        (d) => d.numEmpleado == widget.numEmpleado,
      );
    } catch (e) {
      docente = null; // No se encontró el docente
    }

    final horarios = docenteState.horarios;

    // Si el docente no se encontró, muestra un error.
    if (docente == null) {
      return const Center(
        child: Text('No se pudo encontrar la información del docente.'),
      );
    }

    // Si no hay horarios, mostramos la info y un mensaje.
    if (horarios.isEmpty && !docenteState.isLoading) {
      return _buildLayout(
        docente: docente,
        horarioWidget: const SliverFillRemaining(
          child: Center(
            child: Text("Este docente no tiene horarios asignados."),
          ),
        ),
      );
    }

    // Si todo está correcto, construye la pantalla con la lista de horarios.
    return _buildLayout(
      docente: docente,
      horarioWidget: HorarioList(horarios: horarios),
    );
  }

  // Extraemos el layout principal para reutilizarlo
  Widget _buildLayout({
    required DocenteModel docente,
    required Widget horarioWidget,
  }) {
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
        horarioWidget,
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
