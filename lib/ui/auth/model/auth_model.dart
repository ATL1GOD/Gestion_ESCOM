class Alumno {
  final String boleta;
  final String nombre;
  final String primerApe;
  final String segundoApe;
  final String correo;
  final int activo;
  final String auditoria;

  Alumno({
    required this.boleta,
    required this.nombre,
    required this.primerApe,
    required this.segundoApe,
    required this.correo,
    required this.activo,
    required this.auditoria,
  });

  String get nombreCompleto => '$nombre $primerApe $segundoApe';
}
