import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diacritic/diacritic.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:gestion_escom/ui/academy/model/academia_model.dart'; // Asegúrate de que AcademiaModel esté en este archivo.

// Provider para tu servicio de API (reutilizado de tu archivo anterior)
final apiServiceProvider = Provider((ref) => ApiService());

// 1. Provider para obtener la lista completa de academias desde la API
final academiasProvider = FutureProvider<List<AcademiaModel>>((ref) async {
  // Observa el servicio de API
  final apiService = ref.watch(apiServiceProvider);
  // Llama al nuevo método para obtener las academias
  final response = await apiService.getAcademias();

  // Verifica si la solicitud fue exitosa
  if (response.statusCode == 200 && response.data['data'] != null) {
    // Extrae la lista de academias de la estructura de datos anidada
    final List<dynamic> data = response.data['data']['academias'];
    // Convierte cada objeto JSON en un AcademiaModel
    return data.map((json) => AcademiaModel.fromJson(json)).toList();
  } else {
    // Si algo sale mal, lanza una excepción
    throw Exception('Error al cargar la lista de academias');
  }
});

// 2. Provider para manejar el estado del texto de búsqueda
final academiaSearchQueryProvider = StateProvider<String>((_) => '');

// 3. Provider para filtrar la lista de academias según la búsqueda
final filteredAcademiasProvider = Provider<List<AcademiaModel>>((ref) {
  // Observa el resultado del FutureProvider y el texto de búsqueda
  final allAcademiasAsyncValue = ref.watch(academiasProvider);
  final searchQuery = ref.watch(academiaSearchQueryProvider);

  // Usa maybeWhen para manejar los diferentes estados del FutureProvider (cargando, error, datos)
  return allAcademiasAsyncValue.maybeWhen(
    // Si los datos están disponibles, procede a filtrar
    data: (academias) {
      // Si la búsqueda está vacía, devuelve la lista completa
      if (searchQuery.isEmpty) {
        return academias;
      }

      // Normaliza el texto de búsqueda (minúsculas y sin acentos)
      final query = removeDiacritics(searchQuery.toLowerCase());

      // Filtra la lista de academias
      return academias.where((academia) {
        // Normaliza el nombre de la academia
        final nombreAcademia = removeDiacritics(academia.nombre.toLowerCase());

        // Comprueba si el nombre de la academia contiene el texto de búsqueda
        final matchesNombre = nombreAcademia.contains(query);

        // Comprueba si alguna de las materias contiene el texto de búsqueda
        final matchesMateria = academia.materias.any((materia) {
          final nombreMateria = removeDiacritics(materia.toLowerCase());
          return nombreMateria.contains(query);
        });

        // Devuelve true si hay coincidencia en el nombre O en alguna materia
        return matchesNombre || matchesMateria;
      }).toList();
    },
    // Si está cargando o hay un error, devuelve una lista vacía para la UI
    orElse: () => [],
  );
});
