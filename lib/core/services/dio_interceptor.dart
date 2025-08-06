import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioInterceptor extends Interceptor {
  final _storage = const FlutterSecureStorage();

  // Rutas que no requieren token de autenticación
  final _publicPaths = {'/alumno/login/'};

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Si la ruta no es pública, inyectamos el token
    if (!_publicPaths.contains(options.path)) {
      final token = await _storage.read(key: 'jwt_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Continuamos con la petición
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Aquí puedes manejar errores de forma global, por ejemplo:
    // Si el error es 401 (No autorizado), puedes redirigir al login.
    if (err.response?.statusCode == 401) {
      if (kDebugMode) {
        print('Token expirado o inválido. Se necesita un nuevo login.');
      }
      // Lógica para desloguear al usuario
    }
    super.onError(err, handler);
  }
}
