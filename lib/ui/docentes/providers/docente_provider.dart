import 'package:flutter/material.dart';
import 'package:gestion_escom/ui/docentes/model/docente_model.dart';
import 'package:gestion_escom/ui/docentes/providers/docente_prueba.dart';
import 'package:diacritic/diacritic.dart';

class DocenteProvider extends ChangeNotifier {
  final DocentePrueba _provider = DocentePrueba();
  List<DocenteModel> _docentes = [];
  List<DocenteModel> _docentesFiltrados = [];

  List<DocenteModel> get docentes => _docentesFiltrados;

  // Método para cargar los docentes
  Future<void> cargarDocentes() async {
    _docentes = _provider.getDocentes();
    _docentesFiltrados = List.from(
      _docentes,
    ); // Inicializa con todos los docentes
    notifyListeners();
  }

  // Método de filtrado de docentes
  void filtrarDocentes(String query) {
    String queryWithoutAccents = removeDiacritics(query.toLowerCase());

    _docentesFiltrados = _docentes.where((docente) {
      String nombreWithoutAccents = removeDiacritics(
        docente.nombre.toLowerCase(),
      );
      String primerApeWithoutAccents = removeDiacritics(
        docente.primerApe.toLowerCase(),
      );
      String segundoApeWithoutAccents = removeDiacritics(
        docente.segundoApe.toLowerCase(),
      );
      String correoWithoutAccents = removeDiacritics(
        docente.correo.toLowerCase(),
      );

      return nombreWithoutAccents.contains(queryWithoutAccents) ||
          primerApeWithoutAccents.contains(queryWithoutAccents) ||
          segundoApeWithoutAccents.contains(queryWithoutAccents) ||
          correoWithoutAccents.contains(queryWithoutAccents);
    }).toList();

    notifyListeners(); // Notifica a la vista para que se actualice
  }
}
