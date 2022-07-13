import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/views/details/admission_details/admission_details_screen.dart';
import 'package:hospital_database_app/views/details/doctor_details/doctor_details_screen.dart';
import 'package:hospital_database_app/views/details/patient_details/patient_details_screen.dart';
import 'package:hospital_database_app/views/details/room_details/room_details_screen.dart';
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

  static const detailsScreenIds = <TableType, String>{
    TableType.admissions: AdmissionDetailsScreen.id,
    TableType.patients: PatientDetailsScreen.id,
    TableType.rooms: RoomDetailsScreen.id,
    TableType.doctors: DoctorDetailsScreen.id,
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AdmissionDetailsScreen.id:
        // final data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return const AdmissionDetailsScreen();
          },
        );
      case PatientDetailsScreen.id:
        // final data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return const PatientDetailsScreen();
          },
        );
      case RoomDetailsScreen.id:
        // final data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return const RoomDetailsScreen();
          },
        );
      case DoctorDetailsScreen.id:
        // final data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return const DoctorDetailsScreen();
          },
        );
    }

    return null;
  }
}
