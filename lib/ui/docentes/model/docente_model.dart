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

///////////////////////////
class HorarioModel {
  final String profesor;
  final String idGpo;
  final String aula;
  final String materia;
  final String diaSemana;
  final String ini; // "Ini"
  final String fin; // "Fin"

  HorarioModel({
    required this.profesor,
    required this.idGpo,
    required this.aula,
    required this.materia,
    required this.diaSemana,
    required this.ini,
    required this.fin,
  });

  factory HorarioModel.fromJson(Map<String, dynamic> json) {
    return HorarioModel(
      profesor: json['profesor'] ?? '',
      idGpo: json['idGpo'] ?? '',
      aula: json['aula'] ?? '',
      materia: json['materia'] ?? '',
      diaSemana: json['diaSemana'] ?? '',
      ini: json['Ini'] ?? '', // Nota la mayúscula en "Ini"
      fin: json['Fin'] ?? '', // Nota la mayúscula en "Fin"
    );
  }
}
