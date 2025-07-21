import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestion_escom/ui/auth/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:gestion_escom/core/utils/colors.dart';
import 'package:gestion_escom/ui/auth/widgets/logo_login.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset('assets/images/fondo.png', fit: BoxFit.cover),
        ),
        // Transform.translate(
        // offset: const Offset(0, 70), // mueve hacia abajo 100px child:
        FlutterLogin(
          hideForgotPasswordButton: true,
          userType: LoginUserType.name,

          onLogin: (loginData) async {
            return await ref
                .read(authProvider)
                .login(loginData.name, loginData.password);
          },
          onSubmitAnimationCompleted: () {
            if (kDebugMode) {
              print('NAVEGANDO con GoRouter...');
            }
            context.go('/docentes');
          },
          onRecoverPassword: (String name) async {
            return null;
          },
          theme: LoginTheme(
            primaryColor: Colors.transparent,
            accentColor: Colors.white,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),

            cardTheme: const CardTheme(
              color: AppColors.background,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            buttonStyle: const TextStyle(fontSize: 16),
            textFieldStyle: const TextStyle(fontSize: 14),
            buttonTheme: LoginButtonTheme(
              splashColor: AppColors.textPrimary,
              backgroundColor: AppColors.secondary,
              highlightColor: Colors.cyan,
              elevation: 9.0,
              highlightElevation: 6.0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              // shape: CircleBorder(side: BorderSide(color: Colors.green)),
              // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
            ),
          ),
          messages: LoginMessages(
            userHint: 'Boleta',
            passwordHint: 'CURP',
            loginButton: 'INICIAR SESIÓN',
            forgotPasswordButton: '',
          ),
          userValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'La boleta es obligatoria';
            }
            return null;
          },
          passwordValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'La CURP es obligatoria';
            }
            return null;
          },
        ),

        // Imagen flotante encima del login
        const Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: IgnorePointer(ignoring: true, child: CustomLoginCard()),
        ),
      ],
    );
  }
}
