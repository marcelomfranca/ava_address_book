import 'package:flutter/material.dart';

import '../../infra/themes/decorations.dart';
import 'base_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      showAppBar: true,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: DecorationsAVA.pageLinearBackground,
        child: Center(
          child: Container(
            // constraints: const BoxConstraints(maxHeight: 500),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logos/full_logo.png', height: 100),
                const SizedBox(height: 60),
                const Text('Bem Vindo ao livro de endereços demo AVA!', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 50),
                const Text(
                  'Este não é um app oficial da AVA, foi criado para o desafio proposto em:',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text('github.com/marcelomfranca/ava_address_book',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const Spacer(),
                const Text('heyava.io', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),
                Image.asset('assets/logos/ava_logo_x80.png', height: 40),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(child: Text('v1.0', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
