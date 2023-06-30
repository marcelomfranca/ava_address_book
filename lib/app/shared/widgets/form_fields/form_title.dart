import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }
}
