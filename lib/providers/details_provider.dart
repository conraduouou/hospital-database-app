import 'package:flutter/material.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/column_field.dart';

class DetailsProvider with ChangeNotifier {
  DetailsProvider() {
    headers = List.generate(
      ColumnField.procedureInAdmissionHeaders.length,
      (index) {
        const headers = ColumnField.procedureInAdmissionHeaders;
        final key = headers.keys.elementAt(index);

        return ColumnField(
          contents: key,
          columnSize: headers[key]![0],
          isRemovable: headers[key]![1],
        );
      },
    );

    bodyRows = <List<ColumnField>>[
      ...(() {
        const contents = ColumnField.procedureInAdmissionSample;
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

  AdmissionDetails details = AdmissionDetails();
}
