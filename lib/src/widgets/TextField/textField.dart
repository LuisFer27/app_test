import 'package:app_test/core/route.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool readOnly;
  final ValueSetter<String>?
      onChanged; // Corrección del tipo de parámetro onChanged

  const TextInput({
    required this.controller,
    required this.labelText,
    this.validator,
    this.hintText,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onChanged: onChanged, // Utilizar onChanged si se proporciona
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
