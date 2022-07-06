import 'package:flutter/material.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';
import 'package:hospital_database_app/models/core/column_field.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    headerColumns = <ColumnField>[
      ColumnField(
        contents: 'Admission ID',
        columnSize: ColumnField.admissionIdWidth,
      ),
      ColumnField(
        contents: 'Admission Date',
        columnSize: ColumnField.admissionDateWidth,
      ),
      ColumnField(
        contents: 'Patient Name',
        columnSize: ColumnField.patientNameWidth,
      ),
      ColumnField(
        contents: 'Illness',
        columnSize: ColumnField.illnessNameWidth,
      ),
      ColumnField(
        contents: 'Assigned Doctor',
        columnSize: ColumnField.doctorNameWidth,
      ),
      ColumnField(
        contents: 'Room Number',
        columnSize: ColumnField.roomNumberWidth,
      ),
    ];

    bodyColumns = <ColumnField>[
      ColumnField(contents: 'AID-0012'),
      ColumnField(contents: '3/14/2022'),
      ColumnField(contents: 'John Lloyd Dela Cruz'),
      ColumnField(contents: 'Tuberculosis'),
      ColumnField(contents: 'Dr. Angel R. Sikat'),
      ColumnField(contents: '301'),
    ];
  }

  // data to provide
  late final List<ColumnField> headerColumns;
  late final List<ColumnField> bodyColumns;

  // state management
  bool _isOpened = false;
  final menuItems = <AnimatedMenuItem>[
    AnimatedMenuItem(content: 'Admissions', isSelected: true),
    AnimatedMenuItem(content: 'Patients'),
    AnimatedMenuItem(content: 'Rooms'),
    AnimatedMenuItem(content: 'Doctors'),
    AnimatedMenuItem(content: 'Procedures'),
  ];

  bool get isOpened => _isOpened;

  void toggleOpened() {
    _isOpened = !_isOpened;
    notifyListeners();
  }

  void selectMenuItem(int index) {
    for (final menuItem in menuItems) {
      if (menuItem.isSelected) {
        menuItem.toggleSelected();
        break;
      }
    }

    menuItems[index].toggleSelected();
    notifyListeners();
  }

  void hoverMenuItem(int index, {bool? isHovered}) {
    for (final menuItem in menuItems) {
      if (menuItem.isHovered) {
        menuItem.toggleHovered();
        break;
      }
    }

    menuItems[index].isHovered = isHovered ?? !menuItems[index].isHovered;
    notifyListeners();
  }

  void hideColumns(List<int> indices) {
    for (int i = 0; i < headerColumns.length; i++) {
      if (indices.contains(i)) {
        headerColumns[i].shouldShow = false;
        bodyColumns[i].shouldShow = false;
      }
    }
  }

  void showColumns(List<int> indices) {
    for (int i = 0; i < headerColumns.length; i++) {
      if (indices.contains(i)) {
        headerColumns[i].shouldShow = true;
        bodyColumns[i].shouldShow = true;
      }
    }
  }
}
