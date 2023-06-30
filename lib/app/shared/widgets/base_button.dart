import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.widthFactor,
    this.style,
    this.width = 300,
    this.height = 35,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final double? widthFactor;
  final TextStyle? style;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: (onTap != null)
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
                onTap!();
              }
            : null,
        child: Text(text, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
