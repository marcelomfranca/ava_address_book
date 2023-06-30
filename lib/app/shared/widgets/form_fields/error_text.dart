import 'package:flutter/material.dart';

import '../../../modules/core/infra/themes/styles.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, this.text = '', this.padding = const EdgeInsets.fromLTRB(15, 5, 15, 0)});

  final String text;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text.isNotEmpty,
      child: Padding(
        padding: padding,
        child: Text(text, style: StylesAVA.validateErrorText),
      ),
    );
  }
}
