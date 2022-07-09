import 'package:flutter/material.dart';

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

  final bool isRemovable;

  // admission fields
  static const admissionIdWidth = FixedColumnWidth(130);
  static const admissionDateWidth = FixedColumnWidth(160);
  static const illnessNameWidth = FixedColumnWidth(150);

  // patient fields
  static const patientIdWidth = FixedColumnWidth(100);
  static const patientNameWidth = FixedColumnWidth(230);
  static const patientAgeWidth = FixedColumnWidth(80);
  static const patientGenderWidth = FixedColumnWidth(110);
  static const patientAddressWidth = FixedColumnWidth(380);

  // doctor fields
  static const doctorIdWidth = FixedColumnWidth(100);
  static const doctorNameWidth = FixedColumnWidth(190);
  static const doctorDepartmentWidth = FixedColumnWidth(230);
  static const doctorWorkedOnWidth = FixedColumnWidth(250);
  static const doctorHandlingWidth = FixedColumnWidth(230);

  // room fields
  static const roomNumberWidth = FixedColumnWidth(130);
  static const roomTypeWidth = FixedColumnWidth(250);
  static const roomCostWidth = FixedColumnWidth(120);
  static const roomCapacityWidth = FixedColumnWidth(170);
  static const roomOccupantsWidth = FixedColumnWidth(120);

  // procedure fields
  static const procedureIdWidth = FixedColumnWidth(130);
  static const procedureNameWidth = FixedColumnWidth(230);
  static const procedureCostWidth = FixedColumnWidth(180);
  static const procedureLastDoneWidth = FixedColumnWidth(130);
  static const procedureTimesWidth = FixedColumnWidth(170);

  static const admissionHeaders = <String, FixedColumnWidth>{
    'Admission ID': admissionIdWidth,
    'Admission date': admissionDateWidth,
    'Patient name': patientNameWidth,
    'Illness': illnessNameWidth,
    'Assigned Doctor': doctorNameWidth,
    'Room number': roomNumberWidth,
  };

  static const patientHeaders = <String, FixedColumnWidth>{
    'Patient ID': patientIdWidth,
    'Name': patientNameWidth,
    'Age': patientAgeWidth,
    'Gender': patientGenderWidth,
    'Address': patientAddressWidth,
  };

  static const roomHeaders = <String, FixedColumnWidth>{
    'Room number': roomNumberWidth,
    'Type': roomTypeWidth,
    'Cost': roomCostWidth,
    'Room capacity': roomCapacityWidth,
    'Occupants': roomOccupantsWidth,
  };

  static const doctorHeaders = <String, FixedColumnWidth>{
    'Doctor ID': doctorIdWidth,
    'Name': doctorNameWidth,
    'Department': doctorDepartmentWidth,
    'Admissions worked on': doctorWorkedOnWidth,
    'Currently handling': doctorHandlingWidth,
  };

  static const procedureHeaders = <String, FixedColumnWidth>{
    'Procedure ID': procedureIdWidth,
    'Name': procedureNameWidth,
    'Cost': procedureCostWidth,
    'Last done': procedureLastDoneWidth,
    'Times done': procedureTimesWidth,
  };
}
