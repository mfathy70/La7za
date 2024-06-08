import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/provider/auth_provider.dart';
import 'package:shop_app/core/services/locator_services.dart';
import 'package:shop_app/core/services/navigation_service.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'routes.dart';
import 'theme.dart';

void main() async {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'La7za',
        theme: AppTheme.lightTheme(context),
        scaffoldMessengerKey: locator<NavigationService>().scaffoldMessengerKey,
        navigatorKey: locator<NavigationService>().navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
