import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:hospital_database_app/models/helpers/sql_api_helper.dart';
import 'package:recase/recase.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({
    required this.apiHelper,
  }) {
    headers = [];
    bodyRows = [];

    _heading = TableType.admissions;
    _generateNewTableData();
  }

  // the means for hospital database acquisition
  final SQLApiHelper apiHelper;

  // data to provide
  late List<ColumnField> headers;
  late List<List<ColumnField>> bodyRows;

  // state management
  String _sortText = '';
  TableType _heading = TableType.admissions;
  bool _inAsync = false;
  bool _isOpened = false;
  final menuItems = <AnimatedMenuItem>[
    for (int i = 0; i < TableType.values.length; i++)
      AnimatedMenuItem(
        content: TableType.values[i].name.titleCase,
        isSelected: i == 0,
      ),
  ];

  bool get inAsync => _inAsync;
  bool get isOpened => _isOpened;
  String get sortText => _sortText;
  String get heading => _heading.name.titleCase;
  TableType get headingType => _heading;

  void selectMenuItem(int index) {
    if (menuItems[index].isSelected) {
      // do nothing when the interacted button is already selected
      return;
    }

    for (final menuItem in menuItems) {
      if (menuItem.isSelected) {
        // find the last selected menuItem and toggle it
        menuItem.toggleSelected();
        break;
      }
    }

    for (final type in TableType.values) {
      if (menuItems[index].content.compareTo(type.name.titleCase) == 0) {
        // set _heading String to the current TableType
        _heading = type;
        break;
      }
    }

    // toggle the selected menuItem, usually from false being set to true
    menuItems[index].toggleSelected();
    _sortText = '';

    _generateNewTableData();
  }

  void _generateNewTableData() async {
    // simulate loading
    toggleInAsync();

    final results =
        await apiHelper.callbacksForHome[_heading]!() as List<Details>;

    // clear both headers and bodyRows
    headers.clear();
    bodyRows.clear();

    // this code is going to stay even after sql integration, as table column
    // widths are fixed until a better solution has come up.
    // gets set headers from ColumnField class
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

    // this should now be based on SQL results, probably a getColumnFields method
    // from the abstract Details class.
    bodyRows = List.generate(results.length, (i) {
      final bodyData = results[i].getBodyData(_heading);
      return List.generate(
        bodyData.length,
        (j) => ColumnField(
          contents: bodyData[j],
          columnSize: headers[j].columnSize,
          isRemovable: headers[j].isRemovable,
        ),
      );
    });

    if (isOpened) hideColumns();
    toggleInAsync();
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

        if (headers.indexOf(header) == index) {
          _sortText = '';
          notifyListeners();
          return;
        }
        break;
      }
    }

    final shownHeaders = headers.where((e) => e.shouldShow).toList();
    _sortText = shownHeaders[index].contents;
    shownHeaders[index].isSelected = !shownHeaders[index].isSelected;
    notifyListeners();
  }

  void toggleInAsync() {
    _inAsync = !_inAsync;
    notifyListeners();
  }

  void toggleOpened() {
    _isOpened = !_isOpened;
    notifyListeners();
  }
}
