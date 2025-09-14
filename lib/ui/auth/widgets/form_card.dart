import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_escom/core/utils/colors.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class FormularioCard extends StatefulWidget {
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
  State<FormularioCard> createState() => _FormularioCardState();
}

class _FormularioCardState extends State<FormularioCard> {
  bool _isCurpVisible = false;

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
          key: widget.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Boleta
              TextFormField(
                controller: widget.boletaController,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 14),
                inputFormatters: [UpperCaseTextFormatter()],
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
                controller: widget.curpController,
                textCapitalization: TextCapitalization.characters,
                obscureText: !_isCurpVisible,
                style: const TextStyle(fontSize: 14),
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecoration(
                  hintText: 'CURP',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Cambia el ícono basado en el estado de visibilidad
                      _isCurpVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      // Actualiza el estado al presionar el ícono
                      setState(() {
                        _isCurpVisible = !_isCurpVisible;
                      });
                    },
                  ),
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
              widget.isLoading
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
                        onPressed: widget.onSubmit,
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
