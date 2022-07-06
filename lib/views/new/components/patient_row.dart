import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/custom_dropdown.dart';
import 'package:hospital_database_app/components/custom_field.dart';
import 'package:hospital_database_app/constants.dart';

class PatientRow extends StatelessWidget {
  const PatientRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 500,
      ),
      delegate: SliverChildListDelegate([
        AddBlock(
          heading: 'Patient',
          children: [
            const CustomDropdown(
              text: 'PID-0013 (new)',
              color: kLightGrayColor,
              textColor: kDarkGrayColor,
              enabled: false,
              width: kTextFieldWidth,
            ),
            const CustomField(
              hintText: 'Name',
              width: kTextFieldWidth,
            ),
            const CustomField(
              hintText: 'Address',
              width: kTextFieldWidth,
            ),
            const CustomField(
              hintText: 'Contact number',
              width: kTextFieldWidth,
            ),
            SizedBox(
              width: 380,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CustomField(
                    hintText: 'Age',
                    width: 170,
                  ),
                  CustomDropdown(
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
                  CustomField(
                    hintText: 'Name',
                    width: kTextFieldWidth,
                  ),
                  CustomField(
                    hintText: 'Relation with patient',
                    width: kTextFieldWidth,
                  ),
                  CustomField(
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
