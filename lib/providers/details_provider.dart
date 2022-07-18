import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:hospital_database_app/models/core/doctor_details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';
import 'package:hospital_database_app/models/core/procedure_details.dart';
import 'package:hospital_database_app/models/core/room_details.dart';

class DetailsProvider with ChangeNotifier {
  DetailsProvider({
    required this.tableType,
  }) {
    detailsController = StreamController<Details>();
    detailsStream.listen((acquiredDetails) {
      // assign acquiredDetails to details
      details = acquiredDetails;

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

      // close stream to prevent reloading of resources
      detailsController.close();
      toggleInAsync();
    });

    _getDetails(tableType);
  }

  // data to provide
  late List<ColumnField> headers;
  late List<List<ColumnField>> bodyRows;

  /// The type of table that's going to be displayed on the _ details screen.
  /// This is probably going to be easily confused with the actual table that's
  /// displayed. For example: `ProcedureDetailsScreen` should have a
  /// `DetailsProvider` with `tableType` parameter of `TableType.procedures`,
  /// not `TableType.admissions`).
  final TableType tableType;

  /// The object that contains all the values for a necessary table, often extra.
  Details? details;

  /// The stream that will eventually create the `details` parameter.
  late final StreamController<Details> detailsController;
  Stream<Details> get detailsStream => detailsController.stream;
  Sink<Details> get detailsSink => detailsController.sink;

  /// A flag that determines whether the state is currently undergoing an async
  /// operation.
  bool inAsync = false;

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
  void _getAdmissionDetails() {
    detailsSink.add(
      AdmissionDetails(
        procedures: <ProcedureDetails>[
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
        ],
      ),
    );
  }

  void _getPatientDetails() {
    // detailsSink.add(
    //   PatientDetails(
    //     admissions: <AdmissionDetails>[
    //       AdmissionDetails(
    //         admissionId: 'AID-0012',
    //         admissionDate: DateTime(2022, 3, 14),
    //         illness: 'Tuberculosis',
    //         doctorName: 'Dr. Angel R. Sikat',
    //         roomNumber: 301,
    //       ),
    //     ],
    //   ),
    // );
  }

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

  void _getProcedureDetails() {
    // detailsSink.add(
    //   ProcedureDetails(
    //     admissions: <AdmissionDetails>[
    //       AdmissionDetails(
    //         admissionId: 'AID-0012',
    //         admissionDate: DateTime(2022, 3, 14),
    //         patientName: 'John Lloyd dela Cruz',
    //         illness: 'Tuberculosis',
    //         doctorName: 'Dr. Angel R. Sikat',
    //         roomNumber: 301,
    //       )
    //     ],
    //   ),
    // );
  }

  void _getDoctorDetails() {
    // detailsSink.add(
    //   DoctorDetails(
    //     admissions: <AdmissionDetails>[
    //       AdmissionDetails(
    //         admissionId: 'AID-0012',
    //         admissionDate: DateTime(2022, 3, 14),
    //         dateDischarged: DateTime(2022, 4, 9),
    //         patientName: 'John Lloyd dela Cruz',
    //         roomNumber: 301,
    //       ),
    //     ],
    //   ),
    // );
  }

  void _getDetails(TableType tableType) async {
    // this gets toggled again in the `detailsStream` callback
    toggleInAsync();

    // supply functions for getting different tables
    final callbacks = <TableType, VoidCallback>{
      TableType.admissions: _getAdmissionDetails,
      TableType.patients: _getPatientDetails,
      TableType.rooms: _getRoomDetails,
      TableType.procedures: _getProcedureDetails,
      TableType.doctors: _getDoctorDetails,
    };

    // call appropriate method for getting details according to tableType
    await Future.delayed(const Duration(seconds: 2), () {
      callbacks[tableType]!();
    });
  }

  void toggleInAsync() {
    inAsync = !inAsync;
    notifyListeners();
  }
}
