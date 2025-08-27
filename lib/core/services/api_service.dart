import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dio_interceptor.dart'; // Importamos nuestro interceptor

// Enum para las divisiones, esto previene errores de tipeo.
// ignore: constant_identifier_names
enum Division { DIR, SACAD, SEPI, SSEIS, SADM }

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Constructor que configura Dio
  // Constructor que configura Dio
  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://uteycv.escom.ipn.mx/csi/app-horarios/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    // Añadimos el interceptor a la instancia de Dio
    _dio.interceptors.add(DioInterceptor());
  }

  // --- MÉTODOS PARA CADA ENDPOINT ---

  /// POST /alumnos/login/
  /// Envía la boleta y el CURP para el login del alumno.
  Future<Response> loginAlumno({
    required String boleta,
    required String curp,
  }) async {
    try {
      // Cambio Clave: Enviar los datos como un Map para que coincida
      // con el formato form-data esperado por la API (boleta: valor, curp: valor).
      final formData = {'boleta': boleta, 'curp': curp};

      final response = await _dio.post(
        '/alumnos/login/',
        data: formData,
        // Opcional pero recomendado: Especificar el tipo de contenido
        // que la API espera para este endpoint en particular.
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
      );

      // La API devuelve un token en caso de éxito.
      final token = response.data['token'];
      if (token != null) {
        await _storage.write(key: 'jwt_token', value: token);
      }
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Error en loginAlumno: $e');
      }
      rethrow;
    }
  }

  /// GET /docente/
  /// Obtiene información del docente. El JWT se añade automáticamente por el interceptor.
  Future<Response> getInfoDocente() async {
    try {
      final response = await _dio.get('/docentes/');
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Error en getInfoDocente: $e');
      }
      rethrow;
    }
  }

  /// POST /grupos/{numEmpleado}/
  /// Obtiene los grupos de un docente específico.
  Future<Response> getGruposDocente({required String numEmpleado}) async {
    try {
      final response = await _dio.post('/grupos/$numEmpleado/');
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Error en getGruposDocente: $e');
      }
      rethrow;
    }
  }

  /// POST /horarios/{numEmpleado}/
  /// Obtiene los horarios de un docente específico.
  Future<Response> getHorariosDocente({required String numEmpleado}) async {
    try {
      final response = await _dio.post('/horarios/$numEmpleado/');
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Error en getHorariosDocente: $e');
      }
      rethrow;
    }
  }

  /// POST /directorio/{division}/
  /// Obtiene el directorio de una división específica.
  Future<Response> getDirectorio({required Division division}) async {
    try {
      // Convertimos el enum a String para la URL (ej: Division.SACAD -> "SACAD")
      final divisionString = division.toString().split('.').last;
      final response = await _dio.post('/directorio/$divisionString/');
      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Error en getDirectorio para la división $division: $e');
      }
      rethrow;
    }
  }
}
