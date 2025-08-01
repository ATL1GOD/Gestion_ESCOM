import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  /// Valida que la boleta tenga exactamente 10 dígitos numéricos.
  String? _validateBoleta(String boleta) {
    if (boleta.trim().isEmpty) {
      return 'La boleta es obligatoria.';
    }
    // Expresión regular para validar 10 dígitos exactos
    final boletaRegExp = RegExp(r'^\d{10}$');
    if (!boletaRegExp.hasMatch(boleta)) {
      return 'La boleta debe contener exactamente 10 números.';
    }
    return null; // Retorna null si es válida
  }

  /// Valida el formato de la CURP
  String? _validateCurp(String curp) {
    if (curp.trim().isEmpty) {
      return 'La CURP es obligatoria.';
    }

    if (curp.length != 18) {
      return 'La CURP debe tener exactamente 18 caracteres.';
    }
    // // Expresión regular para el formato de la CURP
    // final curpRegExp = RegExp(
    //   r'^[A-Z]{4}[0-9]{6}[HM][A-Z]{5}[0-9A-Z]{2}$',
    //   caseSensitive: true,
    // );

    // if (!curpRegExp.hasMatch(curp.toUpperCase())) {
    //   return 'El formato de la CURP no es válido.';
    // }
    return null; // Retorna null si es válida
  }

  /// Realiza el login llamando a la API.
  /// Devuelve null si es exitoso, o un mensaje de error si falla.
  Future<String?> login(String boleta, String curp) async {
    final boletaError = _validateBoleta(boleta);
    if (boletaError != null) {
      return boletaError;
    }

    final curpError = _validateCurp(
      curp.toUpperCase(),
    ); // Se convierte a mayúsculas para validar
    if (curpError != null) {
      return curpError;
    }

    try {
      // Llamamos al método de login de nuestro ApiService
      final response = await _apiService.loginAlumno(
        boleta: boleta,
        curp: curp.toUpperCase(), // Se envía la CURP en mayúsculas
      );
      // El método loginAlumno en ApiService ya guarda el token.
      // Si la petición fue exitosa (código 2xx), Dio no lanzará una excepción.
      // La API devuelve un código 1 en caso de éxito
      if (response.data['cod'] == 1) {
        print('Login exitoso. Token guardado.');
        return null;
      } else {
        // Si la API devuelve un código de no-éxito con status 200
        return response.data['msg'] ??
            'Error al iniciar sesion credenciales no validas.';
      }
    } on DioException catch (e) {
      print('Error de Dio en el login: $e');

      if (e.response != null && e.response?.data is Map) {
        // Cambio Clave: Usar la clave "msg" que devuelve tu API en caso de error.
        return e.response?.data['msg'] ??
            'Error de desconocido. Intenta más tarde.';
      }

      return 'No se pudo conectar al servidor. Revisa tu conexión a internet.';
    } catch (e) {
      print('Error inesperado en el login: $e');
      return 'Ocurrió un error inesperado.';
    }
  }
}
