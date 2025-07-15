import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String label;
  final String? errorText;
  final TextEditingController? controller;

  const PasswordInput({
    super.key,
    required this.onChanged,
    this.validator,
    this.label = 'Password',
    this.errorText,
    this.controller,
  });

  @override
  State<PasswordInput> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordInput> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      obscureText: !_isPasswordVisible,
      label: widget.label,
      errorText: widget.errorText,
      controller: widget.controller,
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
