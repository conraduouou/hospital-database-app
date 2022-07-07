import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/column_field.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class AdmissionsBody extends StatelessWidget {
  const AdmissionsBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('body built');
    }
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart,
              left: provider.headerColumns[3].shouldShow ? 95 : 300,
              top: 90,
              child: Row(
                children: [
                  Text(
                    'Admissions',
                    style: kXBoldStyle.copyWith(fontSize: 40),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/add.svg',
                    height: 34,
                  )
                ],
              ),
            ),
            Positioned(
              right: 337,
              top: 94,
              child: SvgPicture.asset(
                'assets/search.svg',
                height: 40,
              ),
            ),
            const Positioned(
              right: 92,
              top: 88,
              child: SortDropdown(),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart,
              left: provider.headerColumns[3].shouldShow ? 90 : 300,
              top: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutQuart,
                    width: provider.headerColumns[3].shouldShow ? 1098 : 888,
                    child: TableHeader(headerColumns: provider.headerColumns),
                  ),
                  const SizedBox(height: 15),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutQuart,
                    width: provider.headerColumns[3].shouldShow ? 1098 : 888,
                    child: TableBody(
                      headerColumns: provider.headerColumns,
                      bodyColumns: provider.bodyColumns,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class TableBody extends StatelessWidget {
  const TableBody({
    Key? key,
    required this.headerColumns,
    required this.bodyColumns,
  }) : super(key: key);

  final List<ColumnField> headerColumns;
  final List<ColumnField> bodyColumns;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final widthsMap = <int, TableColumnWidth>{};

    for (final column in headerColumns.where((element) => element.shouldShow)) {
      widthsMap.addAll({index++: column.columnSize!});
    }

    return Container(
      decoration: BoxDecoration(
        color: kLightGrayColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
        child: Table(
          columnWidths: widthsMap,
          children: [
            TableRow(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kDarkGrayColor,
                    width: 1,
                  ),
                ),
              ),
              children: [
                for (final field
                    in bodyColumns.where((column) => column.shouldShow))
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 10),
                    child: Text(
                      field.contents,
                      style: kBoldStyle.copyWith(
                        fontSize: kRegularSize,
                      ),
                    ),
                  ),
              ],
            ),
            for (int i = 0; i < 4; i++)
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kDarkGrayColor,
                      width: 1,
                    ),
                  ),
                ),
                children: [
                  for (int i = 0;
                      i <
                          bodyColumns
                              .where((element) => element.shouldShow)
                              .length;
                      i++)
                    Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 10),
                      child: Text(
                        '',
                        style: kBoldStyle.copyWith(fontSize: 18),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({
    Key? key,
    required this.headerColumns,
  }) : super(key: key);

  final List<ColumnField> headerColumns;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final widthsMap = <int, TableColumnWidth>{};

    for (final column in headerColumns.where((element) => element.shouldShow)) {
      widthsMap.addAll({index++: column.columnSize!});
    }

    return Container(
      decoration: BoxDecoration(
        color: kGreenishColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
        child: Table(
          columnWidths: widthsMap,
          children: [
            TableRow(
              children: [
                for (final field
                    in headerColumns.where((column) => column.shouldShow))
                  Text(
                    field.contents,
                    style: kBoldStyle.copyWith(
                      color: Colors.white,
                      fontSize: kRegularSize,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SortDropdown extends StatelessWidget {
  const SortDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kLightGrayColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              'Admission date',
              style: kBoldStyle.copyWith(fontSize: kRegularSize),
            ),
            const SizedBox(width: 15),
            SvgPicture.asset(
              'assets/dropdown.svg',
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
