import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/doctor_details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';
import 'package:hospital_database_app/models/core/procedure_details.dart';
import 'package:hospital_database_app/models/core/room_details.dart';
import 'package:hospital_database_app/models/helpers/sql_api_helper.dart';
import 'package:intl/intl.dart';

class NewDetailsProvider with ChangeNotifier {
  NewDetailsProvider({required this.helper});

  final SQLApiHelper helper;

  /// The `AdmissionDetails` object which will be used for inserting via SQL.
  late AdmissionDetails admission;

  /// The `PatientDetails` object which will be used for inserting via SQL.
  late PatientDetails patient;
  late RoomDetails room;
  late DoctorDetails doctor;
  late List<ProcedureDetails> procedures;

  late String newAdmissionId;
  late String newPatientId;
  late String newDoctorId;
  late int newRoomNumber;

  // formula for setting new id in list: newProcedureId + (length - 1 - existing)
  late int newProcedureId;

  // state
  bool _inAsync = false;
  bool _isGettingPatient = false;
  bool _isGettingRoom = false;
  bool _isGettingDoctor = false;
  final List<bool> _isGettingProcedure = [false, false];

  bool get inAsync => _inAsync;
  bool get isGettingPatient => _isGettingPatient;
  bool get isGettingRoom => _isGettingRoom;
  bool get isGettingDoctor => _isGettingDoctor;
  bool isGettingProcedure(int index) => _isGettingProcedure[index];

  // big af switch case method for TextField onChanged
  void onChanged(String s, {required Attribute attribute, int? index}) {
    //TODO: wrap get methods with if-else statement. only get the corresponding
    // details if they don't equal the requested new id. return immediately in
    // that situation.
    switch (attribute) {
      case Attribute.illness:
        admission.illness = s;
        break;
      case Attribute.patientId:
        patient.id = s;
        _getPatient(patient.id!);
        break;
      case Attribute.patientName:
        patient.name = s;
        break;
      case Attribute.patientAddress:
        patient.address = s;
        break;
      case Attribute.patientNumber:
        patient.contactNumber = s;
        break;
      case Attribute.patientAge:
        patient.age = int.tryParse(s) ?? 0;
        break;
      case Attribute.patientGender:
        patient.gender = s;
        break;
      case Attribute.contactName:
        patient.contactPersonName = s;
        break;
      case Attribute.contactRelation:
        patient.contactPersonRelation = s;
        break;
      case Attribute.contactNumber:
        patient.contactPersonNumber = s;
        break;
      case Attribute.roomNumber:
        room.number = int.tryParse(s);
        _getRoom(room.number.toString());
        break;
      case Attribute.roomType:
        room.type = s;
        break;
      case Attribute.roomCost:
        room.cost = double.tryParse(s);
        break;
      case Attribute.roomCapacity:
        room.capacity = int.tryParse(s);
        break;
      case Attribute.doctorId:
        doctor.id = s;
        _getDoctor(doctor.id!);
        break;
      case Attribute.doctorName:
        doctor.name = s;
        break;
      case Attribute.doctorPCF:
        doctor.pcf = int.tryParse(s);
        break;
      case Attribute.doctorDepartment:
        doctor.department = s;
        break;
      case Attribute.procedureId:
        procedures[index!].id = s;
        _getProcedure(procedures[index].id!, index);
        break;
      case Attribute.procedureName:
        procedures[index!].name = s;
        break;
      case Attribute.procedureCost:
        procedures[index!].cost = double.tryParse(s);
        break;
    }

    notifyListeners();
  }

  void onChangeDate(DateTime date) {
    admission.admissionDate = date;
    notifyListeners();
  }

  void _getPatient(String id) async {
    _toggleGettingPatient();
    patient = await helper.getPatientDetailsById(id, includeAdmissions: false);
    _toggleGettingPatient();
  }

  void _getRoom(String id) async {
    _toggleGettingRoom();
    room = await helper.getRoomById(id, includePatients: false);
    _toggleGettingRoom();
  }

  void _getDoctor(String id) async {
    _toggleGettingDoctor();
    doctor = await helper.getDoctorDetailsById(id, includeAdmissions: false);
    _toggleGettingDoctor();
  }

  void _getProcedure(String id, int index) async {
    _toggleGettingProcedure(index);
    procedures[index] =
        await helper.getProcedureById(id, includeAdmissions: false);
    _toggleGettingProcedure(index);
  }

  /// This is called in the build method, not sure if this is a breaking bug...
  ///
  /// The setting of _inAsync in the first line of the method is deliberate,
  /// since the app is currently undergoing a build method and does not need
  /// to be notified of needing a new build, which is an exception.
  ///
  /// This method is made to be called every time before building a whole
  /// New_Screen, and so the need to not call notifyListeners in the beginning.
  void initClass() async {
    _inAsync = true;

    // instantiate objects
    admission = AdmissionDetails();
    patient = PatientDetails();
    room = RoomDetails();
    doctor = DoctorDetails();
    procedures = [ProcedureDetails(), ProcedureDetails()];

    // get IDs via SQLHelper
    newAdmissionId = await helper.getNewAdmissionId();
    newPatientId = await helper.getNewPatientId();
    newDoctorId = await helper.getNewDoctorId();
    newRoomNumber = await helper.getNewRoomNumber();
    newProcedureId = await helper.getNewProcedureId();

    await Future.delayed(const Duration(seconds: 2));

    // assign them to the corresponding objects
    admission.id = newAdmissionId;
    patient.id = newPatientId;
    doctor.id = newDoctorId;
    room.number = newRoomNumber;
    procedures[0].id = NumberFormat('00000').format(newProcedureId);

    _toggleInAsync();
  }

  void _toggleInAsync() {
    _inAsync = !_inAsync;
    notifyListeners();
  }

  void _toggleGettingPatient() {
    _isGettingPatient = !_isGettingPatient;
    notifyListeners();
  }

  void _toggleGettingRoom() {
    _isGettingRoom = !_isGettingRoom;
    notifyListeners();
  }

  void _toggleGettingDoctor() {
    _isGettingDoctor = !_isGettingDoctor;
    notifyListeners();
  }

  void _toggleGettingProcedure(int index) {
    _isGettingProcedure[index] = !_isGettingProcedure[index];
    notifyListeners();
  }

  void addProcedure() {
    procedures.add(ProcedureDetails());
    notifyListeners();
  }

  void removeProcedure(int i) {
    procedures.removeAt(i);
    notifyListeners();
  }
}
