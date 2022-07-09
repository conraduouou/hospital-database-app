import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:recase/recase.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    headers = List.generate(
      ColumnField.admissionHeaders.length,
      (index) {
        final key = ColumnField.admissionHeaders.keys.elementAt(index);

        return ColumnField(
          contents: key,
          columnSize: ColumnField.admissionHeaders[key]![0],
          isRemovable: ColumnField.admissionHeaders[key]![1],
        );
      },
    );

    bodyRows = <List<ColumnField>>[
      ...(() {
        const contents = ColumnField.admissionSample;
        final rows = <List<ColumnField>>[];

        rows.add(
          (() {
            final columnFields = <ColumnField>[];
            for (int i = 0; i < contents.length; i++) {
              columnFields.add(
                ColumnField(
                  contents: contents[i],
                  columnSize: headers[i].columnSize,
                  isRemovable: headers[i].isRemovable,
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
  late List<ColumnField> headers;
  late List<List<ColumnField>> bodyRows;

  // state management
  String _sortText = '';
  TableType _heading = TableType.admissions;
  bool _isOpened = false;
  final menuItems = <AnimatedMenuItem>[
    for (int i = 0; i < TableType.values.length; i++)
      AnimatedMenuItem(
          content: TableType.values[i].name.titleCase, isSelected: i == 0),
  ];

  bool get isOpened => _isOpened;
  String get sortText => _sortText;
  String get heading => _heading.name.titleCase;

  void toggleOpened() {
    _isOpened = !_isOpened;
    notifyListeners();
  }

  void selectMenuItem(int index) {
    if (menuItems[index].isSelected) {
      return;
    }

    for (final menuItem in menuItems) {
      if (menuItem.isSelected) {
        menuItem.toggleSelected();
        break;
      }
    }

    for (final type in TableType.values) {
      if (menuItems[index].content.compareTo(type.name.titleCase) == 0) {
        _heading = type;
        break;
      }
    }

    headers.clear();
    bodyRows.clear();

    headers = List.generate(
      ColumnField.headers[_heading]!.length,
      (index) {
        final key = ColumnField.headers[_heading]!.keys.elementAt(index);

        return ColumnField(
          contents: key,
          columnSize: ColumnField.headers[_heading]![key]![0],
          isRemovable: ColumnField.headers[_heading]![key]![1],
        );
      },
    );

    bodyRows = <List<ColumnField>>[
      [
        for (int i = 0; i < ColumnField.samples[_heading]!.length; i++)
          ColumnField(
            contents: ColumnField.samples[_heading]![i],
            columnSize: headers[i].columnSize,
            isRemovable: headers[i].isRemovable,
          )
      ]
    ];

    _sortText = '';

    hideColumns();

    menuItems[index].toggleSelected();
    notifyListeners();
  }

  void hideColumns() {
    for (int i = 0; i < headers.length; i++) {
      if (headers[i].isRemovable) {
        headers[i].shouldShow = false;

        for (int j = 0; j < bodyRows.length; j++) {
          bodyRows[j][i].shouldShow = false;
        }
      }
    }
  }

  void showColumns() {
    for (int i = 0; i < headers.length; i++) {
      if (headers[i].isRemovable) {
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
          _sortText = '';
          notifyListeners();
          return;
        }
        break;
      }
    }

    _sortText = headers[index].contents;
    headers[index].isSelected = !headers[index].isSelected;
    notifyListeners();

    // if (kDebugMode) {
    //   print('${headers[index].contents}: ${headers[index].isSelected}');
    // }
  }
}
