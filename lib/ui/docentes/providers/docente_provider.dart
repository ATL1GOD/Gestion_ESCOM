import 'package:flutter/material.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:diacritic/diacritic.dart';

class DocenteProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService(); // Instancia de ApiService
  List<DocenteModel> _docentes = [];
  List<DocenteModel> _docentesFiltrados = [];
  bool _isLoading = false;

  List<DocenteModel> get docentes => _docentesFiltrados;
  bool get isLoading => _isLoading;

  Future<void> cargarDocentes() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Asumimos que quieres cargar el directorio de una división, por ejemplo 'DIR'
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
