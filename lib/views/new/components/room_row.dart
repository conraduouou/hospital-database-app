import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
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
            MyDropdownButton(
              text: '302 (new)',
              color: kLightGrayColor,
              textColor: kDarkGrayColor,
              enabled: false,
              width: kTextFieldWidth,
            ),
            MyField(
              hintText: 'Type',
              width: kTextFieldWidth,
            ),
            MyField(
              hintText: 'Cost',
              width: kTextFieldWidth,
            ),
            MyField(
              hintText: 'Capacity',
              width: kTextFieldWidth,
            ),
          ],
        ),
        const AddBlock(
          heading: 'Doctor',
          children: [
            MyDropdownButton(
              text: 'DID-0032 (new)',
              color: kLightGrayColor,
              textColor: kDarkGrayColor,
              enabled: false,
              width: kTextFieldWidth,
            ),
            MyField(
              hintText: 'Name',
              width: kTextFieldWidth,
            ),
            MyField(
              hintText: 'PCF (Peso conversion factor)',
              width: kTextFieldWidth,
            ),
            MyField(
              hintText: 'Department',
              width: kTextFieldWidth,
            ),
          ],
        ),
      ]),
    );
  }
}
