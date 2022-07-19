import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/views/details/admission_details/admission_details_screen.dart';
import 'package:hospital_database_app/views/details/doctor_details/doctor_details_screen.dart';
import 'package:hospital_database_app/views/details/patient_details/patient_details_screen.dart';
import 'package:hospital_database_app/views/details/procedure_details/procedure_details_screen.dart';
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
    TableType.procedures: ProcedureDetailsScreen.id,
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.id:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: 0.0, end: 1.0);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeIn,
            );

            return FadeTransition(
              opacity: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
      case AdmissionDetailsScreen.id:
        final admissionId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => AdmissionDetailsScreen(
            admissionId: admissionId,
          ),
        );
      case PatientDetailsScreen.id:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => PatientDetailsScreen(
            patientId: patientId,
          ),
        );
      case RoomDetailsScreen.id:
        final roomNumber = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => RoomDetailsScreen(
            roomNumber: roomNumber,
          ),
        );
      case DoctorDetailsScreen.id:
        final doctorId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => DoctorDetailsScreen(
            doctorId: doctorId,
          ),
        );
      case ProcedureDetailsScreen.id:
        final procedureId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ProcedureDetailsScreen(
            procedureId: procedureId,
          ),
        );
    }

    return null;
  }
}
