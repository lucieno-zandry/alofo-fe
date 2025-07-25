import 'dart:async';

import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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

  int _resendTimeout = 60;
  Timer? _timer;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    requestToSendConfirmationCode();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      _resendTimeout = 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimeout == 0) {
        timer.cancel();
      } else {
        setState(() {
          _resendTimeout--;
        });
      }
    });
  }

  void requestToSendConfirmationCode() {
    sendConfirmationCode()
        .then((response) {
          if (response.data?['link_sent'] != null &&
              response.data!['link_sent']) {
            Fluttertoast.showToast(
              msg: 'Email confirmation code sent!',
              gravity: ToastGravity.TOP_RIGHT,
            );
          }
        })
        .catchError((error) {
          Fluttertoast.showToast(
            msg: error.toString(),
            gravity: ToastGravity.TOP_RIGHT,
          );
        });
  }

  void _onResendPressed() {
    requestToSendConfirmationCode();
    _startResendTimer();
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

  @override
  Widget build(BuildContext context) {
    AuthDialogState state = Get.find<AuthDialogState>();
    FrontOfficeState frontOfficeState = Get.find<FrontOfficeState>();

    void onSubmit() {
      setState(() {
        isLoading = true;
      });

      final code = _controllers.map((c) => c.text).join();

      matchConfirmationCode(code)
          .then((response) {
            if (response.data?['user'] != null) {
              var user = User.fromJson(response.data!['user']);
              int? nextPageIndex = authDialogMap['create_username']?.index;
              int? currentPageIndex = authDialogMap['email_confirmation_code']?.index;
              List<int>? newHistory = state.history;

              frontOfficeState.setUser(user);

              if (currentPageIndex != null) {
                newHistory.remove(currentPageIndex);
              }

              state.updateState(
                newActive: nextPageIndex,
                newHistory: newHistory,
              );
            }
          })
          .catchError((error) {
            if (error is Map) {
              if (error['errors']?['code'] != null) {
                setState(() {
                  validationMessage = error['errors']['code'][0];
                });
              }
            }
          })
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
    }

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
          onPressed: _isFilled ? onSubmit : null,
          isLoading: isLoading,
          child: const Text('Confirm'),
        ),
        Button(
          variant: 'dark',
          onPressed: _resendTimeout == 0 ? _onResendPressed : null,
          child:
              _resendTimeout == 0
                  ? const Text('Resend Email')
                  : Text('Resend Email ($_resendTimeout)'),
        ),
      ],
    );
  }
}
