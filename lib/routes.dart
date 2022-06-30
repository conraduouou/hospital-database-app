import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/home/home_screen.dart';
import 'package:hospital_database_app/views/login_screen.dart';

class RoutesHandler {
  final Map<String, WidgetBuilder> routes = {
    LoginScreen.id: (context) => const LoginScreen(),
    HomeScreen.id: (context) => const HomeScreen(),
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
    }

    return null;
  }
}
