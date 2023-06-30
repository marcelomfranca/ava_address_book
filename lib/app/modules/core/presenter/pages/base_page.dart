import 'package:address_book/app/modules/core/infra/themes/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/widgets/body_config.dart';
import '../../../../shared/widgets/media_query_config.dart';
import '../../../../shared/widgets/spin_kit_pumping_heart.dart';
import '../widgets/drawer_menu.dart';

class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    this.title = '',
    required this.child,
    this.automaticallyImplyLeading = true,
    this.padding,
    this.showAppBar = true,
    this.scaffoldKey,
    this.floatingActionButton,
    this.withDrawer = false,
    this.leading,
    this.overlay,
  });

  final String title;
  final Widget child;
  final bool automaticallyImplyLeading;
  final EdgeInsets? padding;
  final bool showAppBar;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? floatingActionButton;
  final bool withDrawer;
  final Widget? leading;
  final Widget? overlay;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return MediaQueryConfig(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          decoration: DecorationsAVA.pageLinearBackground,
          child: Stack(
            children: [
              Scaffold(
                key: widget.scaffoldKey,
                drawer: widget.withDrawer
                    ? const Drawer(
                        child: DrawerMenu(),
                      )
                    : null,
                backgroundColor: Colors.transparent,
                appBar: widget.showAppBar
                    ? AppBar(
                        systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.light,
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text(widget.title),
                        centerTitle: true,
                        forceMaterialTransparency: true,
                        automaticallyImplyLeading: widget.automaticallyImplyLeading,
                        leading: widget.leading,
                        actions: <Widget>[
                          InkWell(
                            onTap: () {},
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: SpinKitPumpingHeart(
                                duration: const Duration(seconds: 1),
                                itemBuilder: (context, index) => Image.asset(
                                  'assets/logos/ava_logo_x80.png',
                                  fit: BoxFit.scaleDown,
                                  height: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : null,
                floatingActionButton: widget.floatingActionButton,
                body: BodyConfig(padding: widget.padding, child: widget.child),
              ),
              if (widget.overlay != null) widget.overlay!,
            ],
          ),
        ),
      ),
    );
  }
}
