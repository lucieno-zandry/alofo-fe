import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String label;
  final String? errorText;
  final Widget? suffixIcon;
  final bool obscureText;

  const TextInput({
    super.key,
    required this.onChanged,
    this.validator,
    this.label = 'Mot de passe',
    this.errorText,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        label: Text(label),
        errorText: errorText,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
