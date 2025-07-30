import 'package:flutter/material.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class FormularioCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController boletaController;
  final TextEditingController curpController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const FormularioCard({
    super.key,
    required this.formKey,
    required this.boletaController,
    required this.curpController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Boleta (Username) Text Field
              TextFormField(
                controller: boletaController,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Boleta',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La boleta es obligatoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // CURP (Password) Text Field
              TextFormField(
                controller: curpController,
                obscureText: true,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'CURP',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La CURP es obligatoria';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Login Button
              isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textSecondary,
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          elevation: 9.0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onSubmit,
                        child: const Text(
                          'INICIAR SESIÓN',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
