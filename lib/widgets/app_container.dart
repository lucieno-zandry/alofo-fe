import 'package:alofo/classes/screen.dart';
import 'package:flutter/material.dart';

Map<String, double> getConstraints(BuildContext context) => {
  "standard": Screen.percentageToWidthOf(context, 95),
  "xs": Screen.percentageToWidthOf(context, 90),
  "sm": 540,
  "md": 720,
  "lg": 960,
  "xl": 1140,
  "xxl": 1320,
};

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.decoration,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    String screenType = Screen.getCurrentScreenType(
      MediaQuery.of(context).size.width,
    );

    double width = getConstraints(context)[screenType]!;

    return Center(
      child: Container(
        padding: padding,
        decoration: decoration,
        width: width,
        margin: margin,
        child: child,
      ),
    );
  }
}
