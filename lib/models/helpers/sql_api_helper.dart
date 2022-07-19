import 'package:flutter/foundation.dart';
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
      admissions.add(
        AdmissionDetails(
          id: row['admission_id'],
          admissionDate: row['admission_date'],
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

  Future<AdmissionDetails> getAdmissionDetailsById(String id) async {
    final results = await sqlApi.getAdmissionDetailsById(id);
    final procedures = await getProceduresByAdmissionId(id);
    final result = results.single;

    final admission = AdmissionDetails(
      id: result['admission_id'],
      admissionDate: result['admission_date'],
      dateDischarged: result['date_discharged'],
      illness: result['patient_illness'],
      stayDuration: result['stay_duration'],
      professionalFee: result['professional_fee'],
      roomFee: result['room_fee'],
      labFee: result['lab_fee'],
      patient: PatientDetails(
        id: result['patient_id'],
        name: result['patient_name'],
        age: result['patient_age'],
        gender: result['patient_gender'],
      ),
      doctor: DoctorDetails(
        id: result['doctor_id'],
        name: result['doctor_name'],
        department: result['doctor_department'],
      ),
      room: RoomDetails(
        number: result['room_number'],
        type: result['room_type'],
        cost: result['room_cost'],
      ),
      procedures: procedures,
    );

    return admission;
  }

  Future<List<ProcedureDetails>> getProceduresByAdmissionId(String id) async {
    final results = await sqlApi.getProceduresByAdmissionId(id);
    final procedures = <ProcedureDetails>[];

    for (final row in results) {
      procedures.add(
        ProcedureDetails(
          id: row['procedure_id'],
          name: row['procedure_name'],
          cost: row['procedure_cost'],
          labNumber: row['lab_number'],
          procedureDate: row['procedure_date'],
        ),
      );
    }
    return procedures;
  }

  Future<PatientDetails> getPatientDetailsById(String id) async {
    final results = await sqlApi.getPatientDetailsById(id);
    final admissions = await getAdmissionsByPatientId(id);
    final patientData = results.single;
    if (kDebugMode) print(patientData);
    final patient = PatientDetails(
      id: patientData['patient_id'],
      name: patientData['patient_name'],
      address: patientData['patient_address'],
      contactNumber: patientData['patient_contact_no'],
      age: patientData['patient_age'],
      gender: patientData['patient_gender'],
      contactPersonName: patientData['contact_person'],
      contactPersonRelation: patientData['patient_contact_relation'],
      contactPersonNumber: patientData['contact_person_no'],
      admissions: admissions,
    );
    return patient;
  }

  Future<List<AdmissionDetails>> getAdmissionsByPatientId(String id) async {
    final results = await sqlApi.getAdmissionsByPatientId(id);
    final admissions = <AdmissionDetails>[];

    for (final row in results) {
      admissions.add(
        AdmissionDetails(
          id: row['admission_id'],
          admissionDate: row['admission_date'],
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

  Future<RoomDetails> getRoomById(String id) async {
    final results = await sqlApi.getRoomById(id);
    final result = results.single;
    final room = RoomDetails(
      number: result['room_number'],
      type: result['room_type'],
      cost: result['room_cost'],
      capacity: result['room_capacity'],
    );
    return room;
  }

  Future<List<PatientDetails>> getPatientsByRoomNumber(String id) async {
    final results = await sqlApi.getPatientsByRoomNumber(id);
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

  Future<List<AdmissionDetails>> getAdmissionsByProcedureId(String id) async {
    final results = await sqlApi.getAdmissionsByProcedureId(id);
    final admissions = <AdmissionDetails>[];

    for (final row in results) {
      admissions.add(
        AdmissionDetails(
          id: row['admission_id'],
          admissionDate: row['admission_date'],
          illness: row['patient_illness'],
          patient: PatientDetails(
            name: row['patient_name'],
          ),
          doctor: DoctorDetails(
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

  Future<DoctorDetails> getDoctorDetailsById(String id) async {
    final results = await sqlApi.getDoctorDetailsById(id);
    final admissions = await getAdmissionsByDoctorId(id);
    final result = results.single;
    final doctor = DoctorDetails(
      id: result['doctor_id'],
      name: result['doctor_name'],
      department: result['doctor_department'],
      pcf: result['doctor_pcf'],
      admissions: admissions,
    );
    return doctor;
  }

  Future<List<AdmissionDetails>> getAdmissionsByDoctorId(String id) async {
    final results = await sqlApi.getAdmissionsByDoctorId(id);
    final admissions = <AdmissionDetails>[];

    for (final row in results) {
      admissions.add(
        AdmissionDetails(
          id: row['admission_id'],
          admissionDate: row['admission_date'],
          dateDischarged: row['date_discharged'],
          patient: PatientDetails(
            name: row['patient_name'],
          ),
          room: RoomDetails(number: row['room_number']),
        ),
      );
    }
    return admissions;
  }
}
