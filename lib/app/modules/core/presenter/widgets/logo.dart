import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  const Logo({super.key, this.animale = false});

  final bool animale;

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  late var opacity = widget.animale ? 0.0 : 1.0;

  @override
  void initState() {
    super.initState();

    if (widget.animale) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => opacity = 1.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: opacity,
        child: Image.asset('assets/logos/full_logo.png', fit: BoxFit.scaleDown),
      ),
    );
  }
}
