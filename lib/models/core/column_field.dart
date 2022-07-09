import 'package:flutter/material.dart';

class ColumnField {
  ColumnField({
    required this.contents,
    this.columnSize,
    this.shouldShow = true,
    this.isSelected = false,
  });

  String contents;
  FixedColumnWidth? columnSize;
  bool shouldShow;
  bool isSelected;

  // constants
  static const admissionIdWidth = FixedColumnWidth(130);
  static const admissionDateWidth = FixedColumnWidth(160);
  static const patientNameWidth = FixedColumnWidth(230);
  static const illnessNameWidth = FixedColumnWidth(150);
  static const doctorNameWidth = FixedColumnWidth(190);
  static const roomNumberWidth = FixedColumnWidth(130);
}
