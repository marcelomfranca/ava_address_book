import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.backgroundColor, this.color});

  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.black87.withOpacity(0.5),
      child: Center(child: CircularProgressIndicator(strokeWidth: 1.5, color: color)),
    );
  }
}
