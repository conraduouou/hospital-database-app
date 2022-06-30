import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class AddDropdown extends StatelessWidget {
  const AddDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 240,
      padding: const EdgeInsets.only(right: 20),
      decoration: const BoxDecoration(
        color: kDarkPurpleColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'New admission',
            style: kBoldStyle.copyWith(
              color: Colors.white,
              fontSize: kRegularSize,
            ),
          ),
          Text(
            'New patient',
            style: kBoldStyle.copyWith(
              color: Colors.white,
              fontSize: kRegularSize,
            ),
          ),
          Text(
            'New room',
            style: kBoldStyle.copyWith(
              color: Colors.white,
              fontSize: kRegularSize,
            ),
          ),
          Text(
            'New doctor',
            style: kBoldStyle.copyWith(
              color: Colors.white,
              fontSize: kRegularSize,
            ),
          ),
          Text(
            'New room',
            style: kBoldStyle.copyWith(
              color: Colors.white,
              fontSize: kRegularSize,
            ),
          ),
        ],
      ),
    );
  }
}
