import 'package:flutter/material.dart';

abstract interface class DecorationsAVA {
  static const pageLinearBackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFF8F8F8), Color(0xFFD9D9D9)],
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
