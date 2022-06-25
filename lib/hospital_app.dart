import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/login_screen.dart';

class HospitalApp extends StatelessWidget {
  const HospitalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hospital Database App',
      home: LoginScreen(),
    );
  }
}
