import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class MyTableHeader extends StatelessWidget {
  const MyTableHeader({
    Key? key,
    required this.children,
    this.shouldShow = false,
  }) : super(key: key);

  final List<Widget> children;
  final bool shouldShow;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutQuart,
        width: shouldShow ? 1098 : 888,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 22,
        ),
        decoration: BoxDecoration(
          color: kGreenishColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
