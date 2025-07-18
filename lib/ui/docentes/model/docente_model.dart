class DocenteModel {
  final String numEmpleado;
  final String nombre;
  final String primerApe;
  final String segundoApe;
  final String curp;
  final String correo;
  final String academia;
  final String ubicacion;
  final String auditoria;

  DocenteModel({
    required this.numEmpleado,
    required this.nombre,
    required this.primerApe,
    required this.segundoApe,
    required this.curp,
    required this.correo,
    required this.academia,
    required this.ubicacion,
    required this.auditoria,
  });

  String get nombreCompleto => '$nombre $primerApe $segundoApe';
}
