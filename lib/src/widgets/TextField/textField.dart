import 'package:app_test/core/route.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final String? hintText; // Hint opcional
  final bool readOnly; // Nuevo parámetro readOnly

  const TextInput({
    required this.controller,
    required this.labelText,
    this.validator,
    this.hintText,
    this.readOnly = false, // Valor por defecto es false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly, // Establecer readOnly
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}
