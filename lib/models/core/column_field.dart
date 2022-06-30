import 'package:flutter/material.dart';

class ColumnField {
  ColumnField({
    required this.contents,
    this.columnSize,
    this.shouldShow = true,
  });

  String contents;
  TableColumnWidth? columnSize;
  bool shouldShow;

  // constants
  static const admissionIdWidth = FixedColumnWidth(155);
  static const admissionDateWidth = FixedColumnWidth(185);
  static const patientNameWidth = FixedColumnWidth(227);
  static const illnessNameWidth = FixedColumnWidth(140);
  static const doctorNameWidth = FixedColumnWidth(190);
  static const roomNumberWidth = FixedColumnWidth(140);
}
