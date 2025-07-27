import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. Importar Riverpod
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:gestion_escom/ui/docentes/providers/docente_provider.dart'; // Se asume que aquí está el provider
import 'package:gestion_escom/ui/docentes/widgets/info_card.dart';

// Se asume que el provider está definido en otro lugar (ej. docente_provider.dart o similar)
// Si no lo está, puedes definirlo aquí o en un archivo central de providers.
// extern final docenteProvider; // Ejemplo si estuviera en otro archivo

// 2. Widget Principal - Convertido a ConsumerStatefulWidget
//==============================================================================
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
    // 3. Usar 'ref.read' para llamar a la carga de datos en initState
    // Se ejecuta después de que el primer frame se ha construido.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Llamamos al notifier del provider para cargar los horarios del docente específico.
      ref.read(docenteProvider.notifier).cargarHorarios(widget.numEmpleado);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 4. Usar 'ref.watch' para escuchar los cambios en el estado del provider
    final docenteState = ref.watch(docenteProvider);

    return Scaffold(
      // Muestra un indicador de progreso mientras el estado sea 'isLoading'
      body: docenteState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(docenteState),
    );
  }

  // Widget para construir el contenido una vez que la carga ha terminado
  Widget _buildContent(DocenteProvider docenteState) {
    DocenteModel? docente;
    try {
      // Busca el docente por su 'numEmpleado' en la lista de docentes del provider
      docente = docenteState.docentes.firstWhere(
        (d) => d.numEmpleado == widget.numEmpleado,
      );
    } catch (e) {
      docente = null; // No se encontró el docente
    }

    final horarios = docenteState.horarios;

    // Si el docente o los horarios no están disponibles, muestra un mensaje
    if (docente == null || horarios.isEmpty) {
      return const Center(
        child: Text('No se pudo encontrar la información del docente.'),
      );
    }

    // Si todo está correcto, construye la pantalla de detalles
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const _BackgroundHeader(),
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.settings, color: Colors.white, size: 28),
            onPressed: () {},
          ),
        ),
        Positioned(
          top: 150.0,
          left: 20,
          right: 20,
          // Pasa el docente y el primer horario a la tarjeta de información
          child: DocenteInfoCard(docente: docente),
        ),
        const Positioned(top: 100, left: 0, right: 0, child: _ProfileAvatar()),
      ],
    );
  }
}

// El resto de los widgets permanecen sin cambios
//==============================================================================

class _BackgroundHeader extends StatelessWidget {
  const _BackgroundHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFf3b3c5), Color(0xFFa7aedb)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/profile_illustration.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
