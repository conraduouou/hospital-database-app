import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_table_cell.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/column_field.dart';

class MyTableRow extends StatefulWidget {
  /// Meant to be used with `MyTableBody`. Has configurations dealing with when it
  /// is hovered in respect to the table body.
  const MyTableRow({
    Key? key,
    required this.cellsToShow,
    this.onTap,
  }) : super(key: key);

  final List<ColumnField> cellsToShow;
  final VoidCallback? onTap;

  @override
  State<MyTableRow> createState() => _MyTableRowState();
}

class _MyTableRowState extends State<MyTableRow> {
  Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (isHovered) {
        setState(() {
          color = isHovered ? kGrayColor : null;
        });
      },
      onTap: widget.onTap ?? () {},
      child: Container(
        color: color,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: kDarkGrayColor,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < widget.cellsToShow.length; i++)
                SizedBox(
                  height: 45,
                  width: widget.cellsToShow[i].columnSize!.value,
                  child: MyTableCell(
                    content: widget.cellsToShow[i].contents,
                    textColor: Colors.black,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
