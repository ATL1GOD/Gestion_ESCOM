class DirectorioModel {
  String puesto;
  String funcionario;
  String correo;
  String ext;
  String ubicacion;
  String funciones;

  DirectorioModel({
    required this.puesto,
    required this.funcionario,
    required this.correo,
    required this.ext,
    required this.ubicacion,
    required this.funciones,
  });

  factory DirectorioModel.fromJson(Map<String, dynamic> json) {
    return DirectorioModel(
      puesto: json['puesto'] ?? '',
      funcionario: json['funcionario'] ?? '',
      correo: json['correo'] ?? '',
      ext: json['extension'] ?? '',
      ubicacion: json['ubicacion'] ?? '',
      funciones: json['funciones'] ?? '',
    );
  }
}
