import 'package:flutter/material.dart';

class MediaQueryConfig extends StatelessWidget {
  const MediaQueryConfig({
    Key? key,
    required this.child,
    this.mediaQueryData,
  }) : super(key: key);

  final Widget child;
  final MediaQueryData? mediaQueryData;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQueryData ?? MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child,
    );
  }
}
