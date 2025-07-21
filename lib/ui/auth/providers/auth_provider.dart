import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  Future<String?> login(String boleta, String curp) async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Acepta cualquier dato
    if (boleta.trim().isNotEmpty && curp.trim().isNotEmpty) {
      return null; // Login exitoso
    }

    return 'Campos vacíos';
  }
}
