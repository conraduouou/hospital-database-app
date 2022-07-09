import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

/// The `Widget` used for the tables in the home screen.
class MyTableBody extends StatelessWidget {
  const MyTableBody({
    Key? key,
    required this.rows,
    this.rowCount = 6,
    this.shouldShow = false,
  }) : super(key: key);

  /// The rows to render. Typically contains `MyTableRow` widgets.
  final List<Widget> rows;

  /// Number of rows to render. Typically greater than or equal to 6 to show
  /// empty lines when there are less than 6 records.
  final int rowCount;

  final bool shouldShow;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutQuart,
        height: 315,
        width: shouldShow ? 1098 : 888,
        decoration: BoxDecoration(
          color: kLightGrayColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ListView.builder(
          itemCount: rowCount >= 6 ? rowCount : 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                index == 0 ? const SizedBox(height: 22) : Container(),
                rows[index],
                rowCount > 6 && index == rowCount - 1
                    ? const SizedBox(height: 45)
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
