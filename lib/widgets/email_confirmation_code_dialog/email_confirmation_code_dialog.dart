import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:flutter/material.dart';

class EmailConfirmationCodeDialog extends StatefulWidget {
  const EmailConfirmationCodeDialog({super.key});

  @override
  State<EmailConfirmationCodeDialog> createState() =>
      _EmailConfirmationCodeDialogState();
}

class _EmailConfirmationCodeDialogState
    extends State<EmailConfirmationCodeDialog> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String? validationMessage;
  bool isLoading = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  bool get _isFilled => _controllers.every(
    (c) => c.text.length == 1 && int.tryParse(c.text) != null,
  );

  void _onChanged(int idx, String value) {
    if (value.length == 1 && idx < 5) {
      _focusNodes[idx + 1].requestFocus();
    }
    if (value.isEmpty && idx > 0) {
      _focusNodes[idx - 1].requestFocus();
    }
    setState(() {});
  }

  void _onSubmit() {
    setState(() {
      isLoading = true;
    });

    final code = _controllers.map((c) => c.text).join();
    matchConfirmationCode(code)
        .then((response) {
          if (response['error']?['email'] != null) {
            setState(() {
              validationMessage = response['error']['email'];
            });
          }
        })
        .catchError((error) {
          setState(() {});
        })
        .whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 15,
      children: [
        Text('Enter the 6-digit confirmation code sent to your email:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (idx) {
            return Container(
              width: 40,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: TextFormField(
                controller: _controllers[idx],
                focusNode: _focusNodes[idx],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: const InputDecoration(counterText: ''),
                onChanged: (value) => _onChanged(idx, value),
                inputFormatters: [
                  // Optionally, you can use FilteringTextInputFormatter.digitsOnly
                ],
              ),
            );
          }),
        ),
        if (validationMessage != null)
          Text(
            validationMessage!,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.danger()),
          ),
        Button(
          onPressed: _isFilled ? _onSubmit : null,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
