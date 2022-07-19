import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:hospital_database_app/models/core/doctor_details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';
import 'package:hospital_database_app/models/core/procedure_details.dart';
import 'package:hospital_database_app/models/core/room_details.dart';
import 'package:intl/intl.dart';

class AdmissionDetails implements Details {
  AdmissionDetails({
    this.id,
    this.admissionDate,
    this.dateDischarged,
    this.illness,
    this.stayDuration,
    this.professionalFee,
    this.roomFee,
    this.labFee,
    this.patient,
    this.doctor,
    this.room,
    this.procedures,
  });

  // admission-specific details
  String? id;
  DateTime? admissionDate;
  DateTime? dateDischarged;
  String? illness;
  int? stayDuration;

  // grouped admission-specific data
  Map<String, String> get admissionDetails => <String, String>{
        'Admission ID': id!,
        'Admission date': DateFormat.yMd().format(admissionDate!),
        'Date discharged': dateDischarged == null
            ? 'Still admitted'
            : DateFormat.yMd().format(dateDischarged!),
        'Illness': illness!,
        'Stay duration': stayDuration!.toString(),
      };

  // transaction-specific data
  double? professionalFee;
  double? roomFee;
  double? labFee;

  // grouped transaction-specific data
  Map<String, String> get transaction => <String, String>{
        'Professional fee': professionalFee == null
            ? 'N/A'
            : '${professionalFee!.toStringAsFixed(0)} php',
        'Room fee':
            roomFee == null ? 'N/A' : '${roomFee!.toStringAsFixed(0)} php',
        'Lab fee': labFee == null ? 'N/A' : '${labFee!.toStringAsFixed(0)} php',
        'Total cost': totalCost,
      };

  // patient-specific data
  PatientDetails? patient;

  // grouped patient-specific data
  Map<String, String> get patientDetails => <String, String>{
        'Patient ID': patient!.id!,
        'Name': patient!.name!,
        'Age': patient!.age.toString(),
        'Gender': patient!.gender!,
      };

  // doctor-specific data
  DoctorDetails? doctor;

  // grouped doctor-specific data
  Map<String, String> get doctorDetails => <String, String>{
        'Doctor ID': doctor!.id!,
        'Name': doctor!.name!,
        'Department': doctor!.department!,
      };

  // room-specific data
  RoomDetails? room;

  // grouped room-specific data
  Map<String, String> get roomDetails => <String, String>{
        'Room number': room!.number.toString(),
        'Type': room!.type!,
        'Cost': '${room!.cost!.toStringAsFixed(0)} php',
      };

  List<ProcedureDetails>? procedures;

  String get admissionDateFormatted => DateFormat.yMd().format(admissionDate!);
  String get dateDischargedFormatted =>
      DateFormat.yMd().format(dateDischarged!);

  String get totalCost =>
      '${((professionalFee ?? 0) + (roomFee ?? 0) + (labFee ?? 0)).toStringAsFixed(0)} php';

  @override
  List<String> getBodyData(TableType tableType) {
    if (tableType == TableType.admissions ||
        tableType == TableType.procedures) {
      return [
        id!,
        admissionDateFormatted,
        patient!.name!,
        illness!,
        doctor!.name!,
        room!.number.toString()
      ];
    } else if (tableType == TableType.patients) {
      return [
        id!,
        admissionDateFormatted,
        illness!,
        doctor!.name!,
        room!.number.toString()
      ];
    } else if (tableType == TableType.doctors) {
      return [
        id!,
        admissionDateFormatted,
        dateDischargedFormatted,
        patient!.name!,
        room!.number.toString(),
      ];
    }

    throw 'Unexpected table type supplied in AdmissionDetails class.';
  }

  @override
  List<List<String>> getExtraData() {
    // return none if ever procedures isn't properly supplied
    if (procedures == null) {
      throw 'Procedures aren\'t properly supplied';
    }

    final toReturn = <List<String>>[];

    for (final procedure in procedures!) {
      final procedureDetails = <String>[];

      procedureDetails.add(procedure.id!);
      procedureDetails.add(procedure.name!);
      procedureDetails.add(procedure.costString);
      procedureDetails.add(procedure.labNumber!);
      procedureDetails.add(procedure.procedureDateFormatted);

      toReturn.add(procedureDetails);
    }

    return toReturn;
  }
}
