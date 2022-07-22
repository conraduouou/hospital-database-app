import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';
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

  // list of AnimatedMenuItem classes to store state of the dropdown items
  List<AnimatedMenuItem> dates = [];
  List<AnimatedMenuItem> genders = [];
  List<AnimatedMenuItem> patientIds = [];
  List<AnimatedMenuItem> roomNumbers = [];
  List<AnimatedMenuItem> doctorIds = [];
  List<List<AnimatedMenuItem>> procedureDropdowns = [];
  List<List<AnimatedMenuItem>> procedureDates = [];

  // Map to refer to the AnimatedMenuItem lists
  late Map<DropdownType, List<AnimatedMenuItem>> _dropdowns;

  // state
  bool _inAsync = false;
  bool _isGettingPatient = false;
  bool _isGettingRoom = false;
  bool _isGettingDoctor = false;
  final List<bool> _isGettingProcedure = [false];
  bool _hasPressed = false;

  bool get inAsync => _inAsync;
  bool get isGettingPatient => _isGettingPatient;
  bool get isGettingRoom => _isGettingRoom;
  bool get isGettingDoctor => _isGettingDoctor;
  bool isGettingProcedure(int index) => _isGettingProcedure[index];
  bool get hasPressed => _hasPressed;

  bool get isValidForNewAdmission =>
      admission.isCompleteForNew &&
      patient.isCompleteForNew &&
      room.isCompleteForNew &&
      doctor.isCompleteForNew &&
      proceduresAreComplete();

  /// This is called in the build method, not sure if this is a breaking bug...
  ///
  /// The setting of _inAsync in the first line of the method is deliberate,
  /// since the app is currently undergoing a build method and does not need
  /// to be notified of needing a new build, which is an exception.
  ///
  /// This method is made to be called every time before building a whole
  /// New_Screen, and so the need to not call notifyListeners in the beginning.
  void initClass() async {
    _hasPressed = false;
    _inAsync = true;

    // clear lists
    dates.clear();
    genders.clear();
    patientIds.clear();
    roomNumbers.clear();
    procedureDropdowns.clear();
    procedureDates.clear();
    doctorIds.clear();

    // instantiate objects
    admission = AdmissionDetails();
    patient = PatientDetails();
    room = RoomDetails();
    doctor = DoctorDetails();
    procedures = [ProcedureDetails(id: 'New')];

    // add 'New' values to the list
    patientIds.add(AnimatedMenuItem(content: 'New'));
    doctorIds.add(AnimatedMenuItem(content: 'New'));
    roomNumbers.add(AnimatedMenuItem(content: 'New'));
    procedureDropdowns.add([AnimatedMenuItem(content: 'New')]);
    procedureDates.add(
      [
        AnimatedMenuItem(content: DateFormat.yMd().format(DateTime.now())),
      ],
    );

    // fill lists
    patientIds.addAll(await helper.getPatientIds());
    roomNumbers.addAll(await helper.getRoomNumbers());
    procedureDropdowns[0].addAll(await helper.getProcedureIds());
    doctorIds.addAll(await helper.getDoctorIds());
    genders = List.generate(
        2, (index) => AnimatedMenuItem(content: index == 0 ? 'M' : 'F'));
    dates = List.generate(
      15,
      (index) => AnimatedMenuItem(
        content: DateFormat.yMd().format(
          DateTime.now().subtract(
            Duration(days: index),
          ),
        ),
      ),
    );
    procedureDates[0].addAll(
      List.generate(
        15,
        (index) => AnimatedMenuItem(
          content: DateFormat.yMd().format(
            DateTime.now().subtract(
              Duration(days: index),
            ),
          ),
        ),
      ),
    );

    // assign for utility
    _dropdowns = {
      DropdownType.date: dates,
      DropdownType.gender: genders,
      DropdownType.patient: patientIds,
      DropdownType.room: roomNumbers,
      DropdownType.doctor: doctorIds,
    };

    final split = dates[0].content.split('/').map((e) => int.parse(e)).toList();
    admission.admissionDate = DateTime(split[2], split[0], split[1]);
    patient.id = patientIds[0].content;
    patient.gender = genders[0].content;
    room.number = null;
    doctor.id = doctorIds[0].content;
    procedures[0].id = procedureDropdowns[0][0].content;

    _toggleInAsync();
  }

  // big af switch case method for TextField onChanged
  void onChanged(String s, {required Attribute attribute, int? index}) {
    switch (attribute) {
      case Attribute.illness:
        admission.illness = s;
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
      case Attribute.contactName:
        patient.contactPersonName = s;
        break;
      case Attribute.contactRelation:
        patient.contactPersonRelation = s;
        break;
      case Attribute.contactNumber:
        patient.contactPersonNumber = s;
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
      case Attribute.doctorName:
        doctor.name = s;
        break;
      case Attribute.doctorPCF:
        doctor.pcf = int.tryParse(s);
        break;
      case Attribute.doctorDepartment:
        doctor.department = s;
        break;
      case Attribute.procedureName:
        procedures[index!].name = s;
        break;
      case Attribute.procedureCost:
        procedures[index!].cost = double.tryParse(s);
        break;
      case Attribute.labNumber:
        procedures[index!].labNumber = s;
        break;
    }

    notifyListeners();
  }

  void onSelectItem(
    int index, {
    required DropdownType dropdownType,
    int? procedureIndex,
  }) async {
    switch (dropdownType) {
      case DropdownType.procedure:
        final dropdown = procedureDropdowns[procedureIndex!];
        final item = dropdown[index];
        procedures[procedureIndex].id = item.content;

        if (procedures[procedureIndex].id!.compareTo('New') != 0) {
          _getProcedure(procedures[procedureIndex].id!, procedureIndex);
        } else {
          procedures[procedureIndex] = ProcedureDetails(id: 'New');
        }

        for (final item in dropdown) {
          if (item.isSelected) {
            item.isSelected = false;
            break;
          }
        }

        item.isSelected = true;

        notifyListeners();
        return;
      case DropdownType.date:
        final split =
            dates[index].content.split('/').map((e) => int.parse(e)).toList();
        admission.admissionDate = DateTime(split[2], split[0], split[1]);
        break;
      case DropdownType.procedureDate:
        final dropdown = procedureDates[procedureIndex!];
        final item = dropdown[index];
        final split = item.content.split('/').map((e) => int.parse(e)).toList();

        procedures[procedureIndex].procedureDate = DateTime(
          split[2],
          split[0],
          split[1],
        );

        for (final item in dropdown) {
          if (item.isSelected) {
            item.isSelected = false;
            break;
          }
        }

        item.isSelected = true;
        notifyListeners();
        return;
      case DropdownType.gender:
        patient.gender = _dropdowns[dropdownType]![index].content;
        break;
      case DropdownType.patient:
        patient.id = _dropdowns[dropdownType]![index].content;

        if (patient.id!.compareTo('New') != 0) {
          _getPatient(patient.id!);
        } else {
          patient = PatientDetails(id: 'New', gender: genders[0].content);
        }
        break;
      case DropdownType.doctor:
        doctor.id = _dropdowns[dropdownType]![index].content;

        if (doctor.id!.compareTo('New') != 0) {
          _getDoctor(doctor.id!);
        } else {
          doctor = DoctorDetails(id: 'New');
        }
        break;
      case DropdownType.room:
        room.number = int.tryParse(_dropdowns[dropdownType]![index].content);

        if (room.number != null) {
          _getRoom(room.number.toString());
        } else {
          room = RoomDetails();
        }
        break;
    }

    for (final item in _dropdowns[dropdownType]!) {
      if (item.isSelected) {
        item.isSelected = false;
        break;
      }
    }

    _dropdowns[dropdownType]![index].isSelected = true;
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

  bool proceduresAreComplete() {
    for (final procedure in procedures) {
      if (!procedure.isCompleteForNew) {
        return false;
      }
    }

    return true;
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

  void toggleHasPressed() {
    _hasPressed = true;
    notifyListeners();
  }

  void addProcedure() {
    procedures.add(ProcedureDetails(id: 'New'));
    procedureDropdowns.add(
      List.generate(
        procedureDropdowns[0].length,
        (index) => AnimatedMenuItem(
          content: procedureDropdowns[0][index].content,
        ),
      ),
    );
    procedureDates.add(
      List.generate(
        procedureDates[0].length,
        (index) => AnimatedMenuItem(
          content: procedureDates[0][index].content,
        ),
      ),
    );

    _isGettingProcedure.add(false);

    notifyListeners();
  }

  void removeProcedure(int i) {
    procedures.removeAt(i);
    procedureDropdowns.removeAt(i);
    procedureDates.removeAt(i);
    _isGettingProcedure.removeAt(i);

    notifyListeners();
  }
}
