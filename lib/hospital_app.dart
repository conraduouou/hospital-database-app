import 'package:flutter/material.dart';
import 'package:hospital_database_app/routes.dart';
import 'package:hospital_database_app/views/login_screen.dart';

class HospitalApp extends StatelessWidget {
  HospitalApp({Key? key}) : super(key: key);

  final routesHandler = RoutesHandler();

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: false,
      child: MaterialApp(
        title: 'Hospital Database App',
        routes: routesHandler.routes,
        initialRoute: LoginScreen.id,
        onGenerateRoute: routesHandler.onGenerateRoute,
      ),
    );
  }
}
