import 'package:flutter/foundation.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';
import 'package:hospital_database_app/models/core/procedure_details.dart';

class DetailsProvider with ChangeNotifier {
  DetailsProvider({
    required this.tableType,
  }) {
    // supply functions for getting different tables
    _getDetails = <TableType, VoidCallback>{
      TableType.admissions: _getAdmissionDetails,
      TableType.patients: _getPatientDetails,
      // TableType.rooms: _getRoomDetails,
      TableType.procedures: _getProcedureDetails,
      // TableType.doctors: _getDoctorDetails,
    };

    // call appropriate method for getting details according to tableType
    _getDetails[tableType]!();

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
    bodyRows = <List<ColumnField>>[
      ...(() {
        try {
          final rows = <List<ColumnField>>[];
          final extraData = details.extraData;

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
        } catch (e) {
          return [];
        }
      })()
    ];
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
  late Details details;

  late final Map<TableType, VoidCallback> _getDetails;

  //TODO: implement getting of necessary data for the details screen.
  void _getAdmissionDetails() {
    details = AdmissionDetails();
  }

  void _getPatientDetails() {
    details = PatientDetails();
  }

  // void _getRoomDetails() {
  //   details = RoomDetails();
  // }

  void _getProcedureDetails() {
    details = ProcedureDetails();
  }

  // void _getDoctorDetails() {
  //   details = DoctorDetails();
  // }
}
