import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> initScreenScaffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
