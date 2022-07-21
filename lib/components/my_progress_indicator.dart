import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({
    Key? key,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: const CircularProgressIndicator(
        color: kPurpleColor,
      ),
    );
  }
}
