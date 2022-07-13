import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_table_body.dart';
import 'package:hospital_database_app/components/my_table_cell.dart';
import 'package:hospital_database_app/components/my_table_header.dart';
import 'package:hospital_database_app/components/my_table_row.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:hospital_database_app/routes.dart';
import 'package:hospital_database_app/views/details/admission_details/admission_details_screen.dart';
import 'package:provider/provider.dart';

class MyTable extends StatelessWidget {
  const MyTable({
    Key? key,
    required this.bodyRows,
    required this.headers,
    required this.provider,
    required this.tableType,
    this.isOpened = false,
    this.isAnimated = true,
  }) : super(key: key);

  final List<List<ColumnField>> bodyRows;

  /// The headers with which the column names will be supplied.
  ///
  /// Must be of type `List<ColumnField>`, with `columnSize` of each
  /// corresponding to provided static values in the `ColumnField` class.
  ///
  /// Must also be further filtered to show values that only have the `shouldShow`
  /// parameter set to `true`. Like the code below:
  /// ```dart
  /// final headers = headers.where((h) => h.shouldShow).toList();
  /// ```
  final List<ColumnField> headers;
  final dynamic provider;
  final bool isOpened;
  final bool isAnimated;

  /// Determines which table/screen is being pointed to by the table created by
  /// this widget. That is, which screen to go when a record is pressed.
  ///
  /// If it's in the case of being in the `HomeScreen`, it would be
  /// a no-brainer to label the Procedures table as having Procedure-type values--
  /// but in the _`Details` screens, some are being pointed to a different table
  /// altogether.
  final TableType tableType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTableHeader(
          isAnimated: isAnimated,
          shouldShow: !isOpened,
          children: [
            ...(() {
              // list of headers to render as widgets
              final widgets = <Widget>[];

              // `MyTableRow` isn't used here since `MyTableRow`
              // is used specifically for `MyTableBody`. Instead,
              // separate `MyTableCell`s are used.
              for (int i = 0; i < headers.length; i++) {
                widgets.add(
                  _MyTableCellBuilder(
                    provider: provider,
                    headers: headers,
                    index: i,
                  ),
                );
              }
              return widgets;
            })()
          ],
        ),
        const SizedBox(height: 15),
        MyTableBody(
          isAnimated: isAnimated,
          shouldShow: !isOpened,
          rowCount: bodyRows.length,
          rows: [
            // makes use of spread operator in Dart to lay out
            // list of MyTableRows
            ...(() {
              // the widgets to return
              final widgets = <Widget>[];

              // number of rows to render
              final length = bodyRows.length >= 6 ? bodyRows.length : 6;

              // loop through each row...
              for (int i = 0; i < length; i++) {
                // determine which cells to show
                final cellsToShow = i < bodyRows.length
                    ? bodyRows[i].where((r) => r.shouldShow).toList()
                    : List<ColumnField>.generate(
                        headers.length,
                        (j) => ColumnField(
                          contents: '',
                          columnSize: headers[j].columnSize,
                        ),
                      );

                // pass cells to show and construct via MyTableRow
                widgets.add(
                  MyTableRow(
                    cellsToShow: cellsToShow,
                    onTap: () {
                      // set isHome to false in order to prevent
                      // back button from showing on _Details screens.

                      // while the `ProvidedAppBar` can be explicitly
                      // set with an isHome boolean parameter, this is
                      // good practice nonetheless to prevent more
                      // issues in the future.
                      final appBarProvider = context.read<AppBarProvider>();
                      appBarProvider.isHome = false;

                      if (kDebugMode) {
                        print(RoutesHandler.detailsScreenIds[tableType]);
                      }

                      Navigator.pushNamed(
                        context,
                        RoutesHandler.detailsScreenIds[tableType] ??
                            AdmissionDetailsScreen.id,
                        arguments: 'id',
                      );
                    },
                  ),
                );
              }

              return widgets;
            })()
          ],
        ),
      ],
    );
  }
}

/// special private class for constructing a `Selector` from either `HomeProvider`
/// or `DetailsProvider`.
class _MyTableCellBuilder extends StatelessWidget {
  const _MyTableCellBuilder({
    Key? key,
    required this.provider,
    required this.headers,
    required this.index,
  }) : super(key: key);

  final dynamic provider;
  final List<ColumnField> headers;
  final int index;

  Widget tableCell({required bool isSelected}) {
    return MyTableCell(
      padding: EdgeInsets.zero,
      width: headers[index].columnSize!.value,
      content: headers[index].contents,
      hoverColor: kOffWhiteColor,
      isSelected: isSelected,
      onTap: provider is HomeProvider
          ? () {
              provider.selectHeader(index);
            }
          : null,
    );
  }

  bool isSelectedFromHeader(dynamic provider) {
    final p = provider;

    // get list of headers
    final h = p.headers;
    final headerAtIndex = h[p.headers.indexOf(headers[index])];

    return headerAtIndex.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    // practically does the same thing
    return provider is HomeProvider
        ? Selector<HomeProvider, bool>(
            selector: (ctx, homeProvider) => isSelectedFromHeader(homeProvider),
            builder: (ctx, isSelected, child) =>
                tableCell(isSelected: isSelected),
          )
        : Selector<DetailsProvider, bool>(
            selector: (ctx, detailsProvider) =>
                isSelectedFromHeader(detailsProvider),
            builder: (ctx, isSelected, child) =>
                tableCell(isSelected: isSelected),
          );
  }
}
