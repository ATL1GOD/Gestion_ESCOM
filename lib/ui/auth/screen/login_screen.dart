import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/ui/auth/providers/auth_provider.dart';
import 'package:gestion_escom/ui/auth/widgets/form_card.dart';
import 'package:gestion_escom/ui/auth/widgets/animated_wave.dart';

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

    final error = await ref
        .read(authProvider)
        .login(_boletaController.text, _curpController.text);

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (error == null) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppColors.ipn),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                width: 155,
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage('assets/images/escudo_ESCOM_azul.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormularioCard(
                    formKey: _formKey,
                    boletaController: _boletaController,
                    curpController: _curpController,
                    isLoading: _isLoading,
                    onSubmit: _submitLogin,
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
