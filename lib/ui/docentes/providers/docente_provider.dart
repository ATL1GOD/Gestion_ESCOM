import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:diacritic/diacritic.dart';

final docenteProvider = ChangeNotifierProvider((ref) {
  return DocenteProvider();
});

class DocenteProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService(); // Instancia de ApiService
  // Lista para almacenar los docentes y los docentes filtrados
  List<DocenteModel> _docentes = [];
  List<DocenteModel> _docentesFiltrados = [];
  bool _isLoading = false;
  // Lista para almacenar los horarios
  List<HorarioModel> _horarios = [];
  // Getter para acceder a los docentes y al estado de carga
  List<DocenteModel> get docentes => _docentesFiltrados;
  bool get isLoading => _isLoading;
  // Getter para acceder a los horarios
  List<HorarioModel> get horarios => _horarios;
  // Método para cargar los docentes desde la API
  Future<void> cargarDocentes() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getInfoDocente();

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        _docentes = data.map((json) => DocenteModel.fromJson(json)).toList();
        _docentesFiltrados = List.from(_docentes);
      } else {
        // Manejar el caso de una respuesta no exitosa
        _docentes = [];
        _docentesFiltrados = [];
      }
    } catch (e) {
      // Manejar errores de la petición
      print('Error al cargar docentes: $e');
      _docentes = [];
      _docentesFiltrados = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> cargarHorarios(String numEmpleado) async {
    _isLoading = true; // Indicamos que estamos cargando los horarios
    _horarios = []; // Limpiamos la lista de horarios antes de cargar nuevos
    notifyListeners();

    try {
      final response = await _apiService.getHorariosDocente(
        numEmpleado: numEmpleado,
      );
      ();

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List<dynamic> data = response.data['data'];
        // Convertimos los datos JSON a una lista de HorarioModel
        _horarios = data.map((json) => HorarioModel.fromJson(json)).toList();
      } else {
        // Si no hay datos o hay un error, la lista queda vacía
        _horarios = [];
        print('Error o respuesta sin datos: ${response.data['msj']}');
      }
    } catch (e) {
      print('Error al cargar horarios: $e');
      _horarios = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Método para filtrar docentes por nombre o correo
  void filtrarDocentes(String query) {
    String queryWithoutAccents = removeDiacritics(query.toLowerCase());

    if (queryWithoutAccents.isEmpty) {
      _docentesFiltrados = List.from(_docentes);
    } else {
      _docentesFiltrados = _docentes.where((docente) {
        // Buscamos en el nombre completo y en el correo
        final nombreSinAcentos = removeDiacritics(
          docente.profesor.toLowerCase(),
        );
        final correoSinAcentos = removeDiacritics(docente.correo.toLowerCase());

        return nombreSinAcentos.contains(queryWithoutAccents) ||
            correoSinAcentos.contains(queryWithoutAccents);
      }).toList();
    }
    notifyListeners();
  }
}
