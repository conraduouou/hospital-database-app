import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';

class PatientRow extends StatelessWidget {
  const PatientRow({
    Key? key,
    this.isNew = false,
  }) : super(key: key);

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 500,
      ),
      delegate: SliverChildListDelegate([
        AddBlock(
          heading: isNew ? 'New Patient' : 'Patient',
          children: [
            MyDropdownButton(
              text: 'PID-0013 (new)',
              textColor: kDarkGrayColor,
              showDropdown: !isNew,
              width: kTextFieldWidth,
            ),
            const MyField(
              hintText: 'Name',
              width: kTextFieldWidth,
            ),
            const MyField(
              hintText: 'Address',
              width: kTextFieldWidth,
            ),
            const MyField(
              hintText: 'Contact number',
              width: kTextFieldWidth,
            ),
            SizedBox(
              width: 380,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  MyField(
                    hintText: 'Age',
                    width: 170,
                  ),
                  MyDropdownButton(
                    width: 190,
                    text: 'Gender',
                    textColor: kDarkGrayColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 30),
            Flexible(
              child: AddBlock(
                heading: 'Contact person',
                children: [
                  MyField(
                    hintText: 'Name',
                    width: kTextFieldWidth,
                  ),
                  MyField(
                    hintText: 'Relation with patient',
                    width: kTextFieldWidth,
                  ),
                  MyField(
                    hintText: 'Contact number',
                    width: kTextFieldWidth,
                  ),
                ],
              ),
            ),
            SizedBox(height: 110)
          ],
        ),
      ]),
    );
  }
}
