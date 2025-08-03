import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gestion_escom/core/services/api_service.dart';
import 'package:dio/dio.dart';

// Claves persistencia
const _tokenKey = 'authToken';
const _isLoggedInKey = 'isLoggedIn';

//Provider para la API
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

//Provider para el AuthNotifier (con persistencia)
final authStateProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final api = ref.watch(apiServiceProvider);
  return AuthNotifier(api);
});

// Servicio externo (por si quieres usarlo en pantallas para lógica directa)
final authServiceProvider = Provider<AuthService>((ref) {
  final api = ref.watch(apiServiceProvider);
  return AuthService(api, ref);
});

class AuthNotifier extends StateNotifier<bool> {
  final ApiService _apiService;

  AuthNotifier(this._apiService) : super(false) {
    _loadLoginStatus(); // Carga persistencia al iniciar
  }

  Future<void> _loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> login(String boleta, String curp) async {
    final response = await _apiService.loginAlumno(
      boleta: boleta,
      curp: curp.toUpperCase(),
    );

    if (response.data['cod'] == 1) {
      final token = response.data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      await prefs.setBool(_isLoggedInKey, true);
      state = true;
      print('Login exitoso. Token guardado.');
    } else {
      throw Exception(response.data['msg'] ?? 'Credenciales inválidas');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.setBool(_isLoggedInKey, false);
    state = false;
    print('Sesión cerrada.');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}

class AuthService {
  final ApiService _api;
  final Ref _ref;

  AuthService(this._api, this._ref);

  String? _validateBoleta(String boleta) {
    if (boleta.trim().isEmpty) return 'La boleta es obligatoria.';
    final regExp = RegExp(r'^\d{10}$');
    return regExp.hasMatch(boleta)
        ? null
        : 'Debe contener exactamente 10 números.';
  }

  String? _validateCurp(String curp) {
    if (curp.trim().isEmpty) return 'La CURP es obligatoria.';
    if (curp.length != 18) {
      return 'La CURP debe tener exactamente 18 caracteres.';
    }
    return null;
  }

  Future<String?> login(String boleta, String curp) async {
    final boletaError = _validateBoleta(boleta);
    if (boletaError != null) return boletaError;

    final curpError = _validateCurp(curp);
    if (curpError != null) return curpError;

    try {
      await _ref.read(authStateProvider.notifier).login(boleta, curp);
      return null;
    } on DioException catch (e) {
      print('Dio error: $e');
      return e.response?.data['msg'] ??
          'Error de conexión o credenciales incorrectas.';
    } catch (e) {
      print('Login error: $e');
      return e.toString();
    }
  }

  Future<void> logOut() async {
    await _ref.read(authStateProvider.notifier).logout();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String?> getToken() async {
    return await _ref.read(authStateProvider.notifier).getToken();
  }
}
