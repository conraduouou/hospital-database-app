import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';
import 'package:hospital_database_app/models/core/doctor_details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';
import 'package:hospital_database_app/models/core/procedure_details.dart';
import 'package:hospital_database_app/models/core/room_details.dart';
import 'package:hospital_database_app/models/services/sql_api.dart';
import 'package:intl/intl.dart';

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

  Future<PatientDetails> getPatientDetailsById(
    String id, {
    bool includeAdmissions = true,
  }) async {
    final results = await sqlApi.getPatientDetailsById(id);
    final admissions =
        includeAdmissions ? await getAdmissionsByPatientId(id) : null;
    final patientData = results.single;
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

  Future<RoomDetails> getRoomById(
    String id, {
    bool includePatients = true,
  }) async {
    final results = await sqlApi.getRoomById(id);
    final patients = includePatients ? await getPatientsByRoomNumber(id) : null;
    final result = results.single;
    final room = RoomDetails(
      number: result['room_number'],
      type: result['room_type'],
      cost: result['room_cost'],
      capacity: result['room_capacity'],
      patients: patients,
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

  Future<ProcedureDetails> getProcedureById(
    String id, {
    bool includeAdmissions = true,
  }) async {
    final results = await sqlApi.getProcedureById(id);
    final admissions =
        includeAdmissions ? await getAdmissionsByProcedureId(id) : null;
    final result = results.single;
    final procedure = ProcedureDetails(
      id: result['procedure_id'],
      name: result['procedure_name'],
      cost: result['procedure_cost'],
      timesDone: result['times_done'],
      admissions: admissions,
    );
    return procedure;
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

  Future<DoctorDetails> getDoctorDetailsById(
    String id, {
    bool includeAdmissions = true,
  }) async {
    final results = await sqlApi.getDoctorDetailsById(id);
    final admissions =
        includeAdmissions ? await getAdmissionsByDoctorId(id) : null;
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

  Future<String> getNewAdmissionId() async {
    final results = await sqlApi.getNewAdmissionId();
    final result = results.single;
    final admissionId = result['new_admission_id'];
    return admissionId;
  }

  Future<String> getNewDoctorId() async {
    final results = await sqlApi.getNewDoctorId();
    final result = results.single;
    final doctorId = result['new_doctor_id'];
    return doctorId;
  }

  Future<int> getNewRoomNumber() async {
    final results = await sqlApi.getNewRoomNumber();
    final result = results.single;
    final roomNumber = result['new_room_number'];
    return roomNumber;
  }

  Future<int> getNewProcedureId() async {
    final results = await sqlApi.getNewProcedureId();
    final result = results.single;
    final procedureId = result['new_procedure_id'];
    return procedureId;
  }

  Future<String> getNewPatientId() async {
    final results = await sqlApi.getNewPatientId();
    final result = results.single;
    final patientId = result['new_patient_id'];
    return patientId;
  }

  Future<List<AnimatedMenuItem>> getPatientIds() async {
    final results = await sqlApi.getPatientIds();
    final patientIds = <AnimatedMenuItem>[];

    for (final row in results) {
      patientIds.add(AnimatedMenuItem(content: row['patient_id']));
    }

    return patientIds;
  }

  Future<List<AnimatedMenuItem>> getDoctorIds() async {
    final results = await sqlApi.getDoctorIds();
    final doctorIds = <AnimatedMenuItem>[];

    for (final row in results) {
      doctorIds.add(AnimatedMenuItem(content: row['doctor_id']));
    }

    return doctorIds;
  }

  Future<List<AnimatedMenuItem>> getRoomNumbers() async {
    final results = await sqlApi.getRoomNumbers();
    final roomNumbers = <AnimatedMenuItem>[];

    for (final row in results) {
      roomNumbers.add(AnimatedMenuItem(content: row['room_number'].toString()));
    }

    return roomNumbers;
  }

  Future<List<AnimatedMenuItem>> getProcedureIds() async {
    final results = await sqlApi.getProcedureIds();
    final procedureIds = <AnimatedMenuItem>[];

    for (final row in results) {
      procedureIds.add(AnimatedMenuItem(content: row['procedure_id']));
    }

    return procedureIds;
  }

  Future<void> insertAdmission(AdmissionDetails details) async {
    await sqlApi.insertAdmission(
      illness: details.illness,
      patientId: details.patient!.id!,
      roomNumber: details.room!.number!,
      doctorId: details.doctor!.id!,
    );
  }

  Future<void> insertPatient(PatientDetails details) async {
    await sqlApi.insertPatient(
      name: details.name!,
      address: details.address,
      number: details.contactNumber,
      age: details.age,
      gender: details.gender,
      contactName: details.contactPersonName,
      contactRelation: details.contactPersonRelation,
      contactPersonNumber: details.contactPersonNumber,
    );
  }

  Future<void> insertDoctor(DoctorDetails details) async {
    await sqlApi.insertDoctor(
      name: details.name!,
      department: details.department!,
      pcf: details.pcf!,
    );
  }

  Future<void> insertRoom(RoomDetails details) async {
    await sqlApi.insertRoom(
      type: details.type!,
      cost: details.cost!,
      capacity: details.capacity!,
    );
  }

  Future<void> insertProcedure(ProcedureDetails details) async {
    await sqlApi.insertProcedure(
      name: details.name!,
      cost: details.cost!,
    );
  }

  Future<void> insertProcedureDone(
      AdmissionDetails admission, ProcedureDetails procedure) async {
    await sqlApi.insertProcedureDone(
      admissionId: admission.id!,
      procedureId: procedure.id!,
      labNumber: procedure.labNumber!,
      procedureDate: DateFormat.yMd().format(procedure.procedureDate!),
    );
  }
}
