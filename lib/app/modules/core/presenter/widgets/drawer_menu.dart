import 'package:address_book/app/modules/core/core_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../infra/themes/styles.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final iconSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      child: Column(
        children: [
          Container(
            // color: Colors.amberAccent.withOpacity(0.3),
            constraints: const BoxConstraints(maxHeight: 100),
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Image.asset('assets/logos/full_logo.png', fit: BoxFit.scaleDown)),
          ),
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Text('Olá Usuário!', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          _ListTile(
            title: 'Endereços',
            leading: Icon(Icons.maps_home_work_outlined, size: iconSize),
            onTap: context.pop,
          ),
          _ListTile(
            title: 'Adicionar endereço',
            leading: Icon(Icons.maps_ugc_outlined, size: iconSize),
            onTap: () => context.push('/addressForm'),
          ),
          _ListTile(
            title: 'Trocar senha',
            leading: Icon(Icons.password_rounded, size: iconSize),
            onTap: () => context.push('/changePassword'),
          ),
          _ListTile(
            title: 'Sobre',
            leading: Icon(Icons.info_outline, size: iconSize),
            onTap: () => context.push('/about'),
          ),
          _ListTile(
            title: 'Sair',
            leading: const Icon(Icons.exit_to_app, size: 18),
            onTap: () => CoreApp.authSessionService.endSession(),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(child: Text('v1.0', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))),
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({required this.title, this.leading, this.onTap});

  final String title;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: Colors.black26))),
      child: ListTile(
        title: Text(title, style: StylesAVA.listTileDrawer),
        leading: leading,
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}
