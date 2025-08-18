import 'package:flutter/widgets.dart';

class AuthDialogItem {
  const AuthDialogItem({
    required this.isMandatory,
    required this.widget,
    required this.index,
    required this.title,
  });

  final bool isMandatory;
  final Widget widget;
  final int index;
  final String title;
}
