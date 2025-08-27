import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// UI y colores
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/auth/widgets/form_card.dart';
import 'package:gestion_escom/ui/auth/widgets/animated_wave.dart';

// Providers
import 'package:gestion_escom/ui/auth/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _boletaController = TextEditingController();
  final _curpController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _boletaController.dispose();
    _curpController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Usamos AuthService que encapsula validaciones y login
    final error = await ref
        .read(authServiceProvider)
        .login(_boletaController.text, _curpController.text);

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (error == null) {
      // Ya que el login fue exitoso, el authStateProvider ya cambió a true
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppColors.ipn),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(authStateProvider);

    // Evita mostrar el login si ya está logueado (por precaución)
    if (isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Fondo animado
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedWave(color: AppColors.primary, height: 320, speed: 0.7),
                AnimatedWave(
                  color: AppColors.secondary,
                  height: 300,
                  speed: 1.0,
                  offset: pi,
                ),
                AnimatedWave(
                  color: AppColors.textSecondary,
                  height: 300,
                  speed: 1.4,
                  offset: pi / 2,
                ),
              ],
            ),
          ),

          // Contenido scrollable
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          // Logo
                          Container(
                            width: 155,
                            height: 125,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/escudo_azul.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Formulario
                          Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    400, // opcional para limitar ancho en pantallas grandes
                                maxHeight:
                                    420, // ajusta según el diseño que tenías antes
                              ),
                              child: FormularioCard(
                                formKey: _formKey,
                                boletaController: _boletaController,
                                curpController: _curpController,
                                isLoading: _isLoading,
                                onSubmit: _submitLogin,
                              ),
                            ),
                          ),
                          // Espacio dinámico para evitar que el botón quede tapado
                          SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom + 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
