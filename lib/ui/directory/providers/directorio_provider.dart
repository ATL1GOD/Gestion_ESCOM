import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:gestion_escom/ui/directory/model/directorio_model.dart'; // Asegúrate que la ruta sea correcta

final directorioProvider = ChangeNotifierProvider((ref) {
  return DirectorioProvider();
});

class DirectorioProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  Map<Division, List<DirectorioModel>> _directorioData = {};
  bool _isLoading = false;
  String? _error;

  Map<Division, List<DirectorioModel>> get directorioData => _directorioData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final Map<Division, String> divisionTitles = {
    Division.DIR: 'Dirección',
    Division.SADM: 'Subdirección Administrativa',
    Division.SACED: 'Subdirección Académica',
    Division.SSEIS: 'Subdirección de Servicios Educativos e Integración Social',
    Division.SEPI: 'Sección de Estudios de Posgrado e Investigación',
  };

  DirectorioProvider() {
    cargarDirectorioCompleto();
  }

  /// Ordena los puestos de mayor a menor jerarquía.
  final Map<String, int> _puestoOrder = {
    'DIRECCIÓN': 0,
    'DECANATO': 1,
    'COORDINACIÓN DE ENLACE Y GESTIÓN TÉCNICA': 2,
    'UNIDAD DE INFORMÁTICA': 3,
    'SUBDIRECCIÓN DE SERVICIOS EDUCATIVOS E INTEGRACIÓN SOCIAL': 4,
  };

  /// Carga el directorio para todas las divisiones de forma concurrente.
  Future<void> cargarDirectorioCompleto() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Creamos una lista de futuros, uno para cada división.
      final requests = Division.values.map((division) async {
        try {
          final response = await _apiService.getDirectorio(division: division);
          // Verificamos no solo que 'data' no sea nulo, sino también
          // que sea del tipo correcto (List).
          if (response.statusCode == 200 &&
              response.data['data'] != null &&
              response.data['data'] is List) {
            // Si es una lista, la procesamos como antes.
            final List<dynamic> dataList = response.data['data'];
            final list = dataList
                .map((json) => DirectorioModel.fromJson(json))
                .toList();
            // Ordenamos la lista por el puesto usando el mapa de orden.
            list.sort((a, b) {
              final rankA = _puestoOrder[a.puesto] ?? 999;
              final rankB = _puestoOrder[b.puesto] ?? 999;
              return rankA.compareTo(rankB);
            });
            return MapEntry(division, list);
          } else {
            // Devolvemos una entrada de mapa con una lista vacía para esa división.
            if (response.statusCode == 200 && response.data['data'] != null) {
              print(
                'Advertencia: La API no devolvió una lista para la división $division. Valor recibido: "${response.data['data']}"',
              );
            }
            return MapEntry(division, <DirectorioModel>[]);
          }
        } catch (e) {
          // Si una llamada individual falla por cualquier otra razón, también devolvemos una lista vacía.
          print('Error al procesar la división $division: $e');
          return MapEntry(division, <DirectorioModel>[]);
        }
      }).toList();

      // Esperamos a que todas las peticiones terminen.
      final results = await Future.wait(requests);
      // Creamos el mapa final a partir de los resultados.
      // Esto asegura que _directorioData siempre sea un mapa válido.
      _directorioData = Map.fromEntries(results);
    } catch (e) {
      _error = 'Ocurrió un error general al cargar el directorio: $e';
      print(_error);
    }

    _isLoading = false;
    notifyListeners();
  }
}
