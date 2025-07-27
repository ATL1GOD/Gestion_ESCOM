class DocenteModel {
  final String numEmpleado;
  final String profesor;
  final String sexo;
  final String correo;
  final String ubicacion;

  DocenteModel({
    required this.numEmpleado,
    required this.profesor,
    required this.sexo,
    required this.correo,
    required this.ubicacion,
  });

  // Factory constructor para crear una instancia desde un mapa (JSON)
  factory DocenteModel.fromJson(Map<String, dynamic> json) {
    return DocenteModel(
      numEmpleado: json['numEmpleado'] ?? '',
      profesor: json['profesor'] ?? '',
      sexo: json['sexo'] ?? '',
      correo: json['correo'] ?? '',
      ubicacion: json['ubicacion'] ?? '',
    );
  }
}
