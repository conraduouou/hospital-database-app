import 'package:flutter/material.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:provider/provider.dart';

class AdmissionRow extends StatelessWidget {
  const AdmissionRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewDetailsProvider>();

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 350,
      ),
      delegate: SliverChildListDelegate([
        AddBlock(
          heading: 'New Admission',
          children: [
            Selector<NewDetailsProvider, String?>(
              selector: (ctx, provider) => provider.newAdmissionId,
              builder: (ctx, id, child) {
                return MyField(
                  enabled: false,
                  color: kLightGrayColor,
                  hintText: id,
                  width: kTextFieldWidth,
                );
              },
            ),
            //TODO: implement dropdown logic
            const MyDropdownButton(
              text: '06/24/2022',
              width: kTextFieldWidth,
            ),
            Selector<NewDetailsProvider, String?>(
              selector: (c, p) => p.admission.illness,
              builder: (ctx, illness, child) {
                return MyField(
                  initialText: illness,
                  hintText: 'Illness',
                  width: kTextFieldWidth,
                  onChanged: (s) {
                    provider.onChanged(s, attribute: Attribute.illness);
                  },
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
