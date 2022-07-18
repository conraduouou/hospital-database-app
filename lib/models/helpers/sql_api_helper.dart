import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/doctor_details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';
import 'package:hospital_database_app/models/core/procedure_details.dart';
import 'package:hospital_database_app/models/core/room_details.dart';
import 'package:hospital_database_app/models/services/sql_api.dart';

class SQLApiHelper {
  SQLApiHelper() {
    sqlApi = SQLApi();

    callbacksForHome = {
      TableType.admissions: getAdmissionsForHome,
      TableType.patients: getPatientsForHome,
      TableType.rooms: getRoomsForHome,
      TableType.doctors: getDoctorsForHome,
      TableType.procedures: getProceduresForHome,
    };
  }

  late final SQLApi sqlApi;
  late final Map<TableType, Function> callbacksForHome;

  Future<List<AdmissionDetails>> getAdmissionsForHome() async {
    final results = await sqlApi.getAdmissionsForHome();
    final admissions = <AdmissionDetails>[];

    for (final row in results) {
      final dateString = row['admission_date'] as String;
      final dateSplit =
          dateString.split('/').map<int>((e) => int.parse(e)).toList();
      final actualDate = DateTime(dateSplit[2], dateSplit[0], dateSplit[1]);
      admissions.add(
        AdmissionDetails(
          id: row['admission_id'],
          admissionDate: actualDate,
          patient: PatientDetails(
            id: row['patient_id'],
            name: row['patient_name'],
          ),
          illness: row['patient_illness'],
          doctor: DoctorDetails(
            id: row['doctor_id'],
            name: row['doctor_name'],
          ),
          room: RoomDetails(
            number: row['room_number'],
          ),
        ),
      );
    }

    return admissions;
  }

  Future<List<PatientDetails>> getPatientsForHome() async {
    final results = await sqlApi.getPatientsForHome();
    final patients = <PatientDetails>[];

    for (final row in results) {
      patients.add(
        PatientDetails(
          id: row['patient_id'],
          name: row['patient_name'],
          age: row['patient_age'],
          gender: row['patient_gender'],
          address: row['patient_address'],
        ),
      );
    }

    return patients;
  }

  Future<List<RoomDetails>> getRoomsForHome() async {
    final results = await sqlApi.getRoomsForHome();
    final rooms = <RoomDetails>[];

    for (final row in results) {
      rooms.add(
        RoomDetails(
          number: row['room_number'],
          type: row['room_type'],
          cost: row['room_cost'],
          capacity: row['room_capacity'],
          occupantCount: row['occupants'],
        ),
      );
    }

    return rooms;
  }

  Future<List<DoctorDetails>> getDoctorsForHome() async {
    final results = await sqlApi.getDoctorsForHome();
    final doctors = <DoctorDetails>[];

    for (final row in results) {
      doctors.add(
        DoctorDetails(
          id: row['doctor_id'],
          name: row['doctor_name'],
          department: row['doctor_department'],
          handlingCount: row['currently_handling'],
          admissionCount: row['worked_on'],
        ),
      );
    }

    return doctors;
  }

  Future<List<ProcedureDetails>> getProceduresForHome() async {
    final results = await sqlApi.getProceduresForHome();
    final procedures = <ProcedureDetails>[];

    for (final row in results) {
      procedures.add(
        ProcedureDetails(
          id: row['procedure_id'],
          name: row['procedure_name'],
          cost: row['procedure_cost'],
          lastDone: row['last_done'],
          timesDone: row['times_done'],
        ),
      );
    }

    return procedures;
  }
}
