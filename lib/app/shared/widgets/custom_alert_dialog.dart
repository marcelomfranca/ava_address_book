import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.text, this.actions = const []});

  final String text;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      icon: Lottie.asset('assets/lotties/warning_lottie.json', repeat: true, height: 70),
      actions: actions.isEmpty ? [TextButton(onPressed: context.pop, child: const Text('OK'))] : actions,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text(text, textAlign: TextAlign.center)],
      ),
    );
  }
}
