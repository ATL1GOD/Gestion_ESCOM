import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diacritic/diacritic.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';

// Provider para tu servicio de API (puedes moverlo a un archivo propio)
final apiServiceProvider = Provider((ref) => ApiService());

//provider para manejar la lista de docentes y sus horarios
final allDocentesProvider = FutureProvider<List<DocenteModel>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  final response = await apiService.getInfoDocente();

  if (response.statusCode == 200) {
    final List<dynamic> data = response.data['data'];
    return data.map((json) => DocenteModel.fromJson(json)).toList()
      ..sort((a, b) => a.profesor.compareTo(b.profesor));
  } else {
    throw Exception('Error al cargar la lista de docentes');
  }
});

//provider para obtener los horarios de un docente específico
final horariosDocenteProvider =
    FutureProvider.family<List<HorarioModel>, String>((ref, numEmpleado) async {
      final apiService = ref.watch(apiServiceProvider);
      final response = await apiService.getHorariosDocente(
        numEmpleado: numEmpleado,
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => HorarioModel.fromJson(json)).toList();
      } else {
        // Si no hay horarios, devuelve una lista vacía en lugar de un error.
        return [];
      }
    });

//provider para manejar la búsqueda de docentes
// Este provider mantiene el texto de búsqueda actual
final docenteSearchQueryProvider = StateProvider<String>((_) => '');

// Provider para filtrar la lista de docentes según el texto de búsqueda
final filteredDocentesProvider = Provider<List<DocenteModel>>((ref) {
  // Observa el resultado del FutureProvider y el texto de búsqueda
  final allDocentesAsyncValue = ref.watch(allDocentesProvider);
  final searchQuery = ref.watch(docenteSearchQueryProvider);

  // Si la data de docentes está disponible, la filtramos
  return allDocentesAsyncValue.maybeWhen(
    data: (docentes) {
      if (searchQuery.isEmpty) {
        return docentes; // Sin búsqueda, devuelve la lista completa
      }
      final query = removeDiacritics(searchQuery.toLowerCase());
      return docentes.where((docente) {
        final nombre = removeDiacritics(docente.profesor.toLowerCase());
        final correo = removeDiacritics(docente.correo.toLowerCase());
        return nombre.contains(query) || correo.contains(query);
      }).toList();
    },
    // Si no hay datos (cargando o error), devuelve una lista vacía
    orElse: () => [],
  );
});
