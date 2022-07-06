import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/custom_dropdown.dart';
import 'package:hospital_database_app/components/custom_field.dart';
import 'package:hospital_database_app/constants.dart';

class AdmissionRow extends StatelessWidget {
  const AdmissionRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 350,
      ),
      delegate: SliverChildListDelegate([
        const AddBlock(
          heading: 'New Admission',
          children: [
            CustomField(
              enabled: false,
              color: kLightGrayColor,
              hintText: 'AID-0013',
              width: kTextFieldWidth,
            ),
            CustomDropdown(
              text: '06/24/2022',
              width: kTextFieldWidth,
            ),
            CustomField(
              hintText: 'Illness',
              width: kTextFieldWidth,
            ),
          ],
        ),
      ]),
    );
  }
}
