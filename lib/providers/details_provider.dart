import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:hospital_database_app/models/helpers/sql_api_helper.dart';

class DetailsProvider with ChangeNotifier {
  DetailsProvider({
    required this.tableType,
    required this.id,
    required this.helper,
  }) {
    // supply functions for getting different tables
    _callbacks = {
      TableType.admissions: _getAdmissionDetails,
      TableType.patients: _getPatientDetails,
      TableType.rooms: _getRoomDetails,
      TableType.procedures: _getProcedureDetails,
      TableType.doctors: _getDoctorDetails,
    };

    _getDetails(tableType);
  }

  // data to provide
  late List<ColumnField> headers;
  late List<List<ColumnField>> bodyRows;

  /// Utility parameter that assists in code
  late final Map<TableType, VoidCallback> _callbacks;

  /// The type of table that's going to be displayed on the _ details screen.
  /// This is probably going to be easily confused with the actual table that's
  /// displayed. For example: `ProcedureDetailsScreen` should have a
  /// `DetailsProvider` with `tableType` parameter of `TableType.procedures`,
  /// not `TableType.admissions`).
  final TableType tableType;

  /// provide comment
  final String id;

  ///
  final SQLApiHelper helper;

  /// The object that contains all the values for a necessary table, often extra.
  Details? details;

  /// A flag that determines whether the state is currently undergoing an async
  /// operation.
  bool inAsync = false;

  ///
  bool _isDisposed = false;

  /// Helper method that consolidates `extraData` as a `List` of `List<ColumnField>`s
  /// from the `details` object.
  List<List<ColumnField>> _getRows(List<List<String>> extraData) {
    final rows = <List<ColumnField>>[];

    for (int i = 0; i < extraData.length; i++) {
      rows.add(
        (() {
          final columnFields = <ColumnField>[];

          for (int j = 0; j < extraData[i].length; j++) {
            columnFields.add(
              ColumnField(
                contents: extraData[i][j],
                columnSize: headers[j].columnSize,
                isRemovable: headers[j].isRemovable,
              ),
            );
          }

          return columnFields;
        })(),
      );
    }

    return rows;
  }

  //TODO: implement getting of necessary data for the details screen.
  void _getAdmissionDetails() async =>
      details = await helper.getAdmissionDetailsById(id);

  void _getPatientDetails() async =>
      details = await helper.getPatientDetailsById(id);

  void _getRoomDetails() {
    // detailsSink.add(
    //   RoomDetails(
    //     patients: <PatientDetails>[
    //       PatientDetails(
    //         id: 'PID-0001',
    //         name: 'John Lloyd Dela Cruz',
    //         age: 27,
    //         gender: 'M',
    //         address: '55 Street, Mexico, Pampanga',
    //       ),
    //     ],
    //   ),
    // );
  }

  void _getProcedureDetails() async =>
      details = await helper.getProcedureById(id);

  void _getDoctorDetails() async =>
      details = await helper.getDoctorDetailsById(id);

  void _getDetails(TableType tableType) async {
    // this gets toggled again in the `detailsStream` callback
    toggleInAsync();

    _callbacks[tableType]!();
    // call appropriate method for getting details according to tableType
    await Future.delayed(const Duration(seconds: 2), () {});

    // return prematurely if details is null
    if (details == null) {
      toggleInAsync();
      return;
    }

    // generate ColumnField objects from static data headersData
    final headerData = ColumnField.detailsHeaders[tableType]!;
    headers = List.generate(
      headerData.length,
      (index) {
        final key = headerData.keys.elementAt(index);

        return ColumnField(
          contents: key,
          columnSize: headerData[key]![0],
        );
      },
    );

    // generate rows consisting of ColumnFields according to the extraData
    // parameter of the details object
    bodyRows = _getRows(details!.getExtraData());

    toggleInAsync();
  }

  void toggleInAsync() {
    inAsync = !inAsync;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // don't call extra operations after dispose
  @override
  void notifyListeners() {
    if (!_isDisposed) super.notifyListeners();
  }
}
