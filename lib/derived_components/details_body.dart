import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/my_table.dart';
import 'package:hospital_database_app/providers/details_provider.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({
    Key? key,
    required this.provider,
    required this.extraDataHeading,
    required this.extraDataTableType,
    required this.blockRows,
    this.padding,
  }) : super(key: key);

  /// The provider to be passed to the derived component `MyTable` widget.
  final DetailsProvider provider;

  /// The list of rows (ideally `MyDetailsBlock`s) that will be shown. Every
  /// list is treated as children in a row and can only contain 2 children max.
  ///
  /// The widgets in this list are expected to not have any spacing, since the
  /// class already handles the necessary spaces.
  final List<List<Widget>> blockRows;

  /// The heading of the extraData table that will be shown in the Details screen.
  final String extraDataHeading;

  /// The type of the table that will be shown as extraData, which will also
  /// determine the screen it directs to when a record is clicked.
  final TableType extraDataTableType;

  /// Optional padding for the whole widget.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding ?? const EdgeInsets.only(left: 90.0, top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...(() {
              // process MyDetailsBlock widgets
              final rowsToRender = <Widget>[];

              // for each List<Widget>, process each Widget
              for (int i = 0; i < blockRows.length; i++) {
                final row = blockRows[i];
                final rowToAdd = <Widget>[];

                // for each Widget, add them in the rowsToAdd List
                for (int j = 0; j < row.length; j++) {
                  final block = row[j];
                  rowToAdd.add(block);

                  // ensure that there is a gap in between widgets and not
                  // on after the last widget
                  if (j != row.length - 1) {
                    rowToAdd.add(const SizedBox(width: 120));
                  }
                }

                // add processed List<Widgets> as a Row in the final List to render
                rowsToRender.add(
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: rowToAdd,
                  ),
                );

                // add a SizedBox for every Row widget
                rowsToRender.add(const SizedBox(height: 120));
              }

              return rowsToRender;
            })(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  extraDataHeading,
                  style: kBoldStyle.copyWith(fontSize: kXLargeSize),
                ),
                const SizedBox(height: 30),
                Builder(
                  builder: (context) {
                    return SizedBox(
                      width: 1140,
                      child: MyTable(
                        isAnimated: false,
                        bodyRows: provider.bodyRows,
                        headers: provider.headers,
                        provider: provider,
                        tableType: extraDataTableType,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
