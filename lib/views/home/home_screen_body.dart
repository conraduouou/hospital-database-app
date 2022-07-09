import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_table_body.dart';
import 'package:hospital_database_app/components/my_table_cell.dart';
import 'package:hospital_database_app/components/my_table_header.dart';
import 'package:hospital_database_app/components/my_table_row.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();

    if (kDebugMode) {
      print('body built');
    }

    return Stack(
      children: [
        Selector<HomeProvider, bool>(
          selector: (ctx, provider) => provider.isOpened,
          builder: (ctx, isOpened, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart,
              left: !isOpened ? 95 : 300,
              top: 90,
              child: Row(
                children: [
                  Text(
                    heading,
                    style: kXBoldStyle.copyWith(fontSize: 40),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/add.svg',
                    height: 34,
                  )
                ],
              ),
            );
          },
        ),
        Positioned(
          right: 337,
          top: 94,
          child: SvgPicture.asset(
            'assets/search.svg',
            height: 40,
          ),
        ),
        Selector<HomeProvider, String>(
            selector: (ctx, provider) => provider.sortText,
            builder: (ctx, sortText, child) {
              return Positioned(
                right: 92,
                top: 88,
                child: MyDropdownButton(
                  text: sortText.isEmpty ? 'Sort by' : sortText,
                  textColor: sortText.isEmpty ? kDarkGrayColor : null,
                ),
              );
            }),
        Selector<HomeProvider, bool>(
          selector: (ctx, provider) => provider.isOpened,
          builder: (ctx, isOpened, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart,
              left: !isOpened ? 90 : 300,
              top: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTableHeader(
                    shouldShow: !isOpened,
                    children: [
                      ...(() {
                        // list of headers to render
                        final widgets = <Widget>[];

                        // list of header details
                        final headers = provider.headers
                            .where((h) => h.shouldShow)
                            .toList();

                        // `MyTableRow` isn't used here since `MyTableRow`
                        // is used specifically for `MyTableBody`. Instead,
                        // separate `MyTableCell`s are used.
                        for (int i = 0; i < headers.length; i++) {
                          widgets.add(
                            Selector<HomeProvider, bool>(
                              // provider shortened to p
                              selector: (ctx, p) => p
                                  .headers[p.headers.indexOf(headers[i])]
                                  .isSelected,
                              builder: (ctx, isSelected, child) {
                                return MyTableCell(
                                  width: headers[i].columnSize!.value,
                                  content: headers[i].contents,
                                  hoverColor: kOffWhiteColor,
                                  isSelected: isSelected,
                                  onTap: () {
                                    provider.selectHeader(i);
                                  },
                                );
                              },
                            ),
                          );
                        }
                        return widgets;
                      })()
                    ],
                  ),
                  const SizedBox(height: 15),
                  MyTableBody(
                    shouldShow: !isOpened,
                    rowCount: provider.bodyRows.length,
                    rows: [
                      // makes use of spread operator in Dart to lay out
                      // list of MyTableRows
                      ...(() {
                        // the widgets to return
                        final widgets = <Widget>[];

                        // the rows of the table body
                        final bodyRows = provider.bodyRows;

                        // the header cells
                        final headersToShow = provider.headers
                            .where((h) => h.shouldShow)
                            .toList();

                        // number of rows to render
                        final length =
                            bodyRows.length >= 6 ? bodyRows.length : 6;

                        // loop through each row...
                        for (int i = 0; i < length; i++) {
                          // determine which cells to show
                          final cellsToShow = i == 0
                              ? bodyRows[i].where((r) => r.shouldShow).toList()
                              : List<ColumnField>.generate(
                                  headersToShow.length,
                                  (j) => ColumnField(
                                    contents: '',
                                    columnSize: headersToShow[j].columnSize,
                                  ),
                                );

                          // pass cells to show and construct via MyTableRow
                          widgets.add(
                            MyTableRow(
                              cellsToShow: cellsToShow,
                            ),
                          );
                        }

                        return widgets;
                      })()
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
