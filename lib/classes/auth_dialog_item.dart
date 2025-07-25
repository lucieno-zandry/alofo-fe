import 'package:flutter/widgets.dart';

class AuthDialogItem {
  const AuthDialogItem({
    required this.isMandatory,
    required this.widget,
    required this.index,
  });

  final bool isMandatory;
  final Widget widget;
  final int index;
}
