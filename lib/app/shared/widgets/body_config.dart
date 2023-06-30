import 'package:flutter/material.dart';

class BodyConfig extends StatelessWidget {
  const BodyConfig({Key? key, required this.child, this.padding}) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: child,
    );
  }
}
