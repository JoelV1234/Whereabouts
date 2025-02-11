import 'package:flutter/material.dart';

class NavInit extends StatelessWidget {
  final Widget initialPage;
  final GlobalKey<NavigatorState>? navigatorKey;
  const NavInit({super.key, required this.initialPage, this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => initialPage
        );
      },
    );
  }
}