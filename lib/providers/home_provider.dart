import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';
import 'package:hospital_database_app/models/core/column_field.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    headers = <ColumnField>[
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

    bodyRows = <List<ColumnField>>[
      ...(() {
        final contents = <String>[
          'AID-0012',
          '3/14/2022',
          'John Lloyd Dela Cruz',
          'Tuberculosis',
          'Dr. Angel R. Sikat',
          '301',
        ];

        final rows = <List<ColumnField>>[];

        rows.add(
          (() {
            final columnFields = <ColumnField>[];
            for (int i = 0; i < contents.length; i++) {
              columnFields.add(
                ColumnField(
                  contents: contents[i],
                  columnSize: headers[i].columnSize,
                ),
              );
            }

            return columnFields;
          })(),
        );

        return rows;
      })()
    ];
  }

  // data to provide
  late final List<ColumnField> headers;
  late final List<List<ColumnField>> bodyRows;

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

  void hideColumns(List<int> indices) {
    for (int i = 0; i < headers.length; i++) {
      if (indices.contains(i)) {
        headers[i].shouldShow = false;

        for (int j = 0; j < bodyRows.length; j++) {
          bodyRows[j][i].shouldShow = false;
        }
      }
    }
  }

  void showColumns(List<int> indices) {
    for (int i = 0; i < headers.length; i++) {
      if (indices.contains(i)) {
        headers[i].shouldShow = true;

        for (int j = 0; j < bodyRows.length; j++) {
          bodyRows[j][i].shouldShow = true;
        }
      }
    }
  }

  void selectHeader(int index) {
    for (final header in headers) {
      if (header.isSelected) {
        header.isSelected = false;

        // if (kDebugMode) {
        //   print('${header.contents}: ${header.isSelected}');
        // }

        if (headers.indexOf(header) == index) {
          notifyListeners();
          return;
        }
        break;
      }
    }

    headers[index].isSelected = !headers[index].isSelected;
    notifyListeners();

    // if (kDebugMode) {
    //   print('${headers[index].contents}: ${headers[index].isSelected}');
    // }
  }
}
