import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🖼️ Fondo de imagen
          Image.asset('assets/images/fondo.png', fit: BoxFit.cover),

          // 🌫️ Opcional: capa semitransparente para oscurecer el fondo
          Container(color: Color.fromRGBO(0, 0, 0, 0.3)),

          // 🧱 Contenido del login (formulario)
          Center(
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0XFFe3f4ff),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006699),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/images/login_imagen.png',
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'Boleta',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF006699),
                          width: 2,
                        ),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xFF006699),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'CURP',
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF006699),
                          width: 2,
                        ),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xFF006699),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006699),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Datos ingresados'),
                            content: Text(
                              'Correo: $email\nContraseña: $password',
                            ),
                          ),
                        );
                      },
                      child: const Text('Ingresar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
