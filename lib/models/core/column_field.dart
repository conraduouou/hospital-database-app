import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class ColumnField {
  ColumnField({
    required this.contents,
    this.columnSize,
    this.isRemovable = false,
    this.shouldShow = true,
    this.isSelected = false,
  });

  String contents;
  FixedColumnWidth? columnSize;
  bool shouldShow;
  bool isSelected;

  /// Determines whether this specific column field can be triggered viewable
  /// or not via the `shouldShow` property.
  final bool isRemovable;

  // admission fields
  static const admissionIdWidth = FixedColumnWidth(160);
  static const admissionDateWidth = FixedColumnWidth(180);
  static const illnessNameWidth = FixedColumnWidth(120);

  // patient fields
  static const patientIdWidth = FixedColumnWidth(130);
  static const patientNameWidth = FixedColumnWidth(200);
  static const patientAgeWidth = FixedColumnWidth(80);
  static const patientGenderWidth = FixedColumnWidth(110);
  static const patientAddressWidth = FixedColumnWidth(300);

  // doctor fields
  static const doctorIdWidth = FixedColumnWidth(160);
  static const doctorNameWidth = FixedColumnWidth(200);
  static const doctorDepartmentWidth = FixedColumnWidth(190);
  static const doctorWorkedOnWidth = FixedColumnWidth(250);
  static const doctorHandlingWidth = FixedColumnWidth(210);

  // room fields
  static const roomNumberWidth = FixedColumnWidth(150);
  static const roomTypeWidth = FixedColumnWidth(240);
  static const roomCostWidth = FixedColumnWidth(110);
  static const roomCapacityWidth = FixedColumnWidth(175);
  static const roomOccupantsWidth = FixedColumnWidth(130);

  // procedure fields
  static const procedureIdWidth = FixedColumnWidth(165);
  static const procedureNameWidth = FixedColumnWidth(180);
  static const procedureCostWidth = FixedColumnWidth(140);
  static const procedureLastDoneWidth = FixedColumnWidth(140);
  static const procedureTimesWidth = FixedColumnWidth(140);
  static const procedureLabNumberWidth = FixedColumnWidth(140);
  static const procedureDateWidth = FixedColumnWidth(140);

  static const admissionHeaders = <String, Map<int, dynamic>>{
    'Admission ID': {0: admissionIdWidth, 1: false},
    'Admission date': {0: admissionDateWidth, 1: false},
    'Patient name': {0: patientNameWidth, 1: false},
    'Illness': {0: illnessNameWidth, 1: true},
    'Assigned Doctor': {0: doctorNameWidth, 1: true},
    'Room number': {0: roomNumberWidth, 1: false},
  };

  static const admissionSample = <String>[
    'AID-0012',
    '3/14/2022',
    'John Lloyd Dela Cruz',
    'Tuberculosis',
    'Dr. Angel R. Sikat',
    '301',
  ];

  static const patientHeaders = <String, Map<int, dynamic>>{
    'Patient ID': {0: patientIdWidth, 1: false},
    'Name': {0: patientNameWidth, 1: false},
    'Age': {0: patientAgeWidth, 1: false},
    'Gender': {0: patientGenderWidth, 1: false},
    'Address': {0: patientAddressWidth, 1: false},
  };

  static const patientSample = <String>[
    'PID-0001',
    'John Lloyd Dela Cruz',
    '27',
    'M',
    '55 Street, Mexico, Pampanga',
  ];

  static final admissionInPatientHeaders = Map.fromEntries(
      admissionHeaders.entries.where((e) => e.key != 'Patient name'))
    ..update('Illness', (value) => {0: const FixedColumnWidth(140), 1: false});

  static const admissionInDoctorHeaders = <String, Map<int, dynamic>>{
    'Admission ID': {0: admissionIdWidth, 1: false},
    'Admission Date': {0: admissionDateWidth, 1: false},
    'Date Discharged': {0: admissionDateWidth, 1: false},
    'Patient name': {0: patientNameWidth, 1: false},
    'Room number': {0: roomNumberWidth, 1: false},
  };

  static const roomHeaders = <String, Map<int, dynamic>>{
    'Room number': {0: roomNumberWidth, 1: false},
    'Type': {0: roomTypeWidth, 1: false},
    'Cost': {0: roomCostWidth, 1: false},
    'Room capacity': {0: roomCapacityWidth, 1: false},
    'Occupants': {0: roomOccupantsWidth, 1: false},
  };

  static const roomSample = <String>[
    '301',
    'Intensive Care Unit (ICU)',
    '3500 php',
    '4',
    'Occupants',
  ];

  static const doctorHeaders = <String, Map<int, dynamic>>{
    'Doctor ID': {0: doctorIdWidth, 1: false},
    'Name': {0: doctorNameWidth, 1: false},
    'Department': {0: doctorDepartmentWidth, 1: false},
    'Admissions worked on': {0: doctorWorkedOnWidth, 1: true},
    'Currently handling': {0: doctorHandlingWidth, 1: false},
  };

  static const doctorSample = <String>[
    'DID-0031',
    'Dr. Angel R. Sikat',
    'Pulmonology',
    '4',
    '3',
  ];

  static const procedureHeaders = <String, Map<int, dynamic>>{
    'Procedure date': {0: procedureIdWidth, 1: false},
    'Name': {0: procedureNameWidth, 1: false},
    'Cost': {0: procedureCostWidth, 1: false},
    'Last done': {0: procedureLastDoneWidth, 1: false},
    'Times done': {0: procedureTimesWidth, 1: false},
  };

  static const procedureSample = <String>[
    '0012',
    'Antigen Testing',
    '4000 php',
    '3/15/2022',
    '3',
  ];

  static const procedureInAdmissionHeaders = <String, Map<int, dynamic>>{
    'Procedure ID': {0: procedureIdWidth, 1: false},
    'Name': {0: procedureNameWidth, 1: false},
    'Cost': {0: procedureCostWidth, 1: false},
    'Lab number': {0: procedureLabNumberWidth, 1: false},
    'Date': {0: procedureDateWidth, 1: false},
  };

  static const procedureInAdmissionSample = <String>[
    '0012',
    'Antigen Testing',
    '4000 php',
    '00154',
    '3/15/2022',
  ];

  static final detailsHeaders = <TableType, Map<String, Map<int, dynamic>>>{
    TableType.admissions: procedureInAdmissionHeaders,
    TableType.patients: admissionInPatientHeaders,
    TableType.rooms: patientHeaders,
    TableType.doctors: admissionInDoctorHeaders,
    TableType.procedures: admissionHeaders,
  };

  static const headers = <TableType, Map<String, Map<int, dynamic>>>{
    TableType.admissions: admissionHeaders,
    TableType.patients: patientHeaders,
    TableType.rooms: roomHeaders,
    TableType.doctors: doctorHeaders,
    TableType.procedures: procedureHeaders,
  };

  static const samples = <TableType, List<String>>{
    TableType.admissions: admissionSample,
    TableType.patients: patientSample,
    TableType.rooms: roomSample,
    TableType.doctors: doctorSample,
    TableType.procedures: procedureSample,
  };
}
