import 'package:flutter/material.dart';

import 'custom_alert_dialog.dart';

class YesOrNoDialog extends StatelessWidget {
  const YesOrNoDialog({super.key, required this.yesCallBack, required this.noCallBack, required this.text});

  final String text;
  final VoidCallback yesCallBack;
  final VoidCallback noCallBack;

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      text: text,
      actions: [
        TextButton(onPressed: yesCallBack, child: const Text('Não')),
        TextButton(onPressed: noCallBack, child: const Text('Sim'))
      ],
    );
  }
}
