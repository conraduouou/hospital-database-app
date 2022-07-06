import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/add_block.dart';
import 'package:hospital_database_app/components/custom_dropdown.dart';
import 'package:hospital_database_app/components/custom_field.dart';
import 'package:hospital_database_app/constants.dart';

class RoomRow extends StatelessWidget {
  const RoomRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 420,
      ),
      delegate: SliverChildListDelegate([
        const AddBlock(
          heading: 'Room',
          children: [
            CustomDropdown(
              text: '302 (new)',
              color: kLightGrayColor,
              textColor: kDarkGrayColor,
              enabled: false,
              width: kTextFieldWidth,
            ),
            CustomField(
              hintText: 'Type',
              width: kTextFieldWidth,
            ),
            CustomField(
              hintText: 'Cost',
              width: kTextFieldWidth,
            ),
            CustomField(
              hintText: 'Capacity',
              width: kTextFieldWidth,
            ),
          ],
        ),
        const AddBlock(
          heading: 'Doctor',
          children: [
            CustomDropdown(
              text: 'DID-0032 (new)',
              color: kLightGrayColor,
              textColor: kDarkGrayColor,
              enabled: false,
              width: kTextFieldWidth,
            ),
            CustomField(
              hintText: 'Name',
              width: kTextFieldWidth,
            ),
            CustomField(
              hintText: 'PCF (Peso conversion factor)',
              width: kTextFieldWidth,
            ),
            CustomField(
              hintText: 'Department',
              width: kTextFieldWidth,
            ),
          ],
        ),
      ]),
    );
  }
}
