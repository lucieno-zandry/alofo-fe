import 'package:flutter/material.dart';

class Sponsor extends StatelessWidget {
  const Sponsor({super.key, required this.image, required this.brand});

  final Widget image;
  final Widget brand;

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 10, children: [image, brand]);
  }
}
