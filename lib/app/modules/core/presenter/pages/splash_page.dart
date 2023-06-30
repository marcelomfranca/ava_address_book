import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../infra/themes/decorations.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationsAVA.pageLinearBackground,
      child: Center(
        child: Lottie.asset(
          'assets/lotties/logo_lottie.json',
          repeat: true,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
      ),
    );
  }
}
