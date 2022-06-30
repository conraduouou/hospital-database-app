import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class GearDropdown extends StatelessWidget {
  const GearDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
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
            'Change password',
            style: kBoldStyle.copyWith(
              color: Colors.white,
              fontSize: kRegularSize,
            ),
          ),
          Text(
            'Sign out',
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
