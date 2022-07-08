import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/home/home_screen.dart';
import 'package:hospital_database_app/views/login_screen.dart';
import 'package:hospital_database_app/views/new/new_admission.dart';
import 'package:hospital_database_app/views/new/new_doctor.dart';
import 'package:hospital_database_app/views/new/new_patient.dart';
import 'package:hospital_database_app/views/new/new_procedure.dart';
import 'package:hospital_database_app/views/new/new_room.dart';

class RoutesHandler {
  final Map<String, WidgetBuilder> routes = {
    LoginScreen.id: (context) => const LoginScreen(),
    HomeScreen.id: (context) => const HomeScreen(),
    NewAdmissionScreen.id: (context) => const NewAdmissionScreen(),
    NewPatientScreen.id: (context) => const NewPatientScreen(),
    NewRoomScreen.id: (context) => const NewRoomScreen(),
    NewDoctorScreen.id: (context) => const NewDoctorScreen(),
    NewProcedureScreen.id: (context) => const NewProcedureScreen(),
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
    }

    return null;
  }
}
