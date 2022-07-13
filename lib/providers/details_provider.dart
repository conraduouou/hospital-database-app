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
    getDetails = <TableType, VoidCallback>{
      TableType.admissions: getAdmissionDetails,
      TableType.patients: getPatientDetails,
      // TableType.rooms: getRoomDetails,
      TableType.procedures: getProcedureDetails,
      // TableType.doctors: getDoctorDetails,
    };

    getDetails[tableType]!();
    final headerData = ColumnField.detailsHeaders[tableType]!;

    headers = List.generate(
      headerData.length,
      (index) {
        final key = headerData.keys.elementAt(index);

        return ColumnField(
          contents: key,
          columnSize: headerData[key]![0],
          isRemovable: headerData[key]![1],
        );
      },
    );

    bodyRows = <List<ColumnField>>[
      ...(() {
        final rows = <List<ColumnField>>[];
        final bodyData = details.extraData;

        if (kDebugMode) {
          print(bodyData.length);
        }

        for (int i = 0; i < bodyData.length; i++) {
          rows.add(
            (() {
              final columnFields = <ColumnField>[];

              for (int j = 0; j < bodyData[i].length; j++) {
                columnFields.add(
                  ColumnField(
                    contents: bodyData[i][j],
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

  late final Map<TableType, VoidCallback> getDetails;

  //TODO: implement getting of necessary data for the details screen.
  void getAdmissionDetails() {
    details = AdmissionDetails();
  }

  void getPatientDetails() {
    details = PatientDetails();
  }

  // void getRoomDetails() {
  //   details = RoomDetails();
  // }

  void getProcedureDetails() {
    details = ProcedureDetails();
  }

  // void getDoctorDetails() {
  //   details = DoctorDetails();
  // }
}
