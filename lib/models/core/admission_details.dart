import 'package:hospital_database_app/models/core/procedure_details.dart';
import 'package:intl/intl.dart';

class AdmissionDetails {
  AdmissionDetails({
    this.admissionId = 'AID-0012',
    // this.admissionDate,
    // this.dateDischarged,
    this.illness = 'Tuberculosis',
    this.stayDuration = 26,
    this.professionalFee = 50000,
    this.roomFee = 100000,
    this.labFee = 7000,
    this.patientId = 'PID-0001',
    this.patientName = 'John Lloyd Dela Cruz',
    this.patientAge = 27,
    this.patientGender = 'M',
    this.doctorId = 'DID-0031',
    this.doctorName = 'Dr. Angel R. Sikat',
    this.doctorDepartment = 'Pulmonology',
    this.roomNumber = 301,
    this.roomType = 'Intensive Care Unit (ICU)',
    this.roomCost = 3500,
    this.procedures,
  });

  // admission-specific details
  String admissionId;
  DateTime admissionDate = DateTime(2022, 3, 14);
  DateTime dateDischarged = DateTime(2022, 4, 9);
  String illness;
  int stayDuration;

  // grouped admission-specific data
  Map<String, String> get admission => <String, String>{
        'Admission ID': admissionId,
        'Admission date': DateFormat('M/d/y').format(admissionDate),
        'Date discharged': DateFormat('M/d/y').format(dateDischarged),
        'Illness': illness,
        'Stay duration': stayDuration.toString(),
      };

  // transaction-specific data
  double professionalFee;
  double roomFee;
  double labFee;

  // grouped transaction-specific data
  Map<String, String> get transaction => <String, String>{
        'Professional fee': '${professionalFee.toStringAsFixed(0)} php',
        'Room fee': '${roomFee.toStringAsFixed(0)} php',
        'Lab fee': '${labFee.toStringAsFixed(0)} php',
        'Total cost': totalCost,
      };

  // patient-specific data
  String patientId;
  String patientName;
  int patientAge;
  String patientGender;

  // grouped patient-specific data
  Map<String, String> get patient => <String, String>{
        'Patient ID': patientId,
        'Name': patientName,
        'Age': patientAge.toString(),
        'Gender': patientGender,
      };

  // doctor-specific data
  String doctorId;
  String doctorName;
  String doctorDepartment;

  // grouped doctor-specific data
  Map<String, String> get doctor => <String, String>{
        'Doctor ID': doctorId,
        'Name': doctorName,
        'Department': doctorDepartment,
      };

  // room-specific data
  int roomNumber;
  String roomType;
  double roomCost;

  // grouped room-specific data
  Map<String, String> get room => <String, String>{
        'Room number': roomNumber.toString(),
        'Type': roomType,
        'Cost': '${roomCost.toStringAsFixed(0)} php',
      };

  List<ProcedureDetails>? procedures = <ProcedureDetails>[
    ProcedureDetails(
      id: '0012',
      name: 'Antigen Testing',
      cost: 4000,
      labNumber: '00154',
      procedureDate: DateTime(2022, 3, 15),
    ),
    ProcedureDetails(
      id: '0045',
      name: 'X-ray',
      cost: 2000,
      labNumber: '00123',
      procedureDate: DateTime(2022, 3, 15),
    ),
    ProcedureDetails(
      id: '00453',
      name: 'Antigen Testing',
      cost: 4000,
      labNumber: '00453',
      procedureDate: DateTime(2022, 3, 15),
    )
  ];

  String get totalCost =>
      '${(professionalFee + roomFee + labFee).toStringAsFixed(0)} php';
}
