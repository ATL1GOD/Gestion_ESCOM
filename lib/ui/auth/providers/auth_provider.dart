import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Asegúrate de que la ruta de importación sea correcta
import 'package:gestion_escom/core/services/api_service.dart';

// Provider para exponer la instancia de ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// Provider para el servicio de autenticación
// Ahora depende de apiServiceProvider para poder usar ApiService
final authProvider = Provider<AuthService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthService(apiService);
});

class AuthService {
  // Hacemos que AuthService dependa de ApiService
  final ApiService _apiService;
  AuthService(this._apiService);

  /// Realiza el login llamando a la API.
  /// Devuelve null si es exitoso, o un mensaje de error si falla.
  Future<String?> login(String boleta, String curp) async {
    // Validamos que los campos no estén vacíos antes de llamar a la API
    if (boleta.trim().isEmpty || curp.trim().isEmpty) {
      return 'La boleta y la CURP son obligatorias.';
    }

    try {
      // Llamamos al método de login de nuestro ApiService
      final response = await _apiService.loginAlumno(
        boleta: boleta,
        curp: curp,
      );

      // El método loginAlumno en ApiService ya guarda el token.
      // Si la petición fue exitosa (código 2xx), Dio no lanzará una excepción.
      // La librería flutter_login espera `null` para un login exitoso.
      // La API devuelve un código 1 en caso de éxito
      if (response.data['cod'] == 1) {
        print('Login exitoso. Token guardado.');
        return null; // ¡Login exitoso para flutter_login!
      } else {
        // Si la API devuelve un código de no-éxito con status 200
        return response.data['msg'] ?? 'Error desconocido.';
      }
    } on DioException catch (e) {
      print('Error de Dio en el login: $e');

      if (e.response != null && e.response?.data is Map) {
        // Cambio Clave: Usar la clave "msg" que devuelve tu API en caso de error.
        return e.response?.data['msg'] ?? 'Error de autenticación.';
      }

      return 'No se pudo conectar al servidor. Revisa tu conexión a internet.';
    } catch (e) {
      print('Error inesperado en el login: $e');
      return 'Ocurrió un error inesperado.';
    }
  }
}
