import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/login_screen.dart';

class RoutesHandler {
  final Map<String, WidgetBuilder> routes = {
    LoginScreen.id: (context) => const LoginScreen(),
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      default:
    }

    return null;
  }
}
