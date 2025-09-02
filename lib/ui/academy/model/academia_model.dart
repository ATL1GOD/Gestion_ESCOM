class AcademiaModel {
  final String id;
  final String nombre;
  final String presidente;
  final List<String> materias;

  AcademiaModel({
    required this.id,
    required this.nombre,
    required this.presidente,
    required this.materias,
  });

  factory AcademiaModel.fromJson(Map<String, dynamic> json) {
    // Convertimos la lista de materias de dynamic a String.
    var materiasFromJson = json['materias'] as List;
    List<String> materiasList = materiasFromJson.cast<String>();

    return AcademiaModel(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      presidente: json['presidente'] ?? '',
      materias: materiasList,
    );
  }
}
