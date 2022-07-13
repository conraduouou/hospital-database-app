import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_sharp,
            color: kPurpleColor,
            size: 80,
          ),
          const SizedBox(height: 30),
          Text(
            'There was an error in getting the data.',
            style: kBoldStyle.copyWith(fontSize: kLargeSize),
          ),
        ],
      ),
    );
  }
}
