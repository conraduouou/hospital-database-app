import 'package:flutter/material.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:provider/provider.dart';

class PatientRow extends StatelessWidget {
  const PatientRow({
    Key? key,
    this.isNew = false,
  }) : super(key: key);

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewDetailsProvider>();
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 500,
      ),
      delegate: SliverChildListDelegate([
        AddBlock(
          heading: isNew ? 'New Patient' : 'Patient',
          children: [
            Selector<NewDetailsProvider, String?>(
              selector: (ctx, provider) => provider.newPatientId,
              builder: (ctx, id, child) {
                return MyDropdownButton(
                  text: id ?? '',
                  textColor: kDarkGrayColor,
                  showDropdown: !isNew,
                  width: kTextFieldWidth,
                );
              },
            ),
            Selector<NewDetailsProvider, String?>(
              selector: (c, p) => p.patient.name,
              builder: (ctx, name, child) {
                return MyField(
                  initialText: name,
                  hintText: 'Name',
                  width: kTextFieldWidth,
                  onChanged: (s) {
                    provider.onChanged(s, attribute: Attribute.patientName);
                  },
                );
              },
            ),
            Selector<NewDetailsProvider, String?>(
              selector: (c, p) => p.patient.address,
              builder: (ctx, address, child) {
                return MyField(
                  initialText: address,
                  hintText: 'Address',
                  width: kTextFieldWidth,
                  onChanged: (s) {
                    provider.onChanged(s, attribute: Attribute.patientAddress);
                  },
                );
              },
            ),
            Selector<NewDetailsProvider, String?>(
              selector: (c, p) => p.patient.contactNumber,
              builder: (ctx, number, child) {
                return MyField(
                  initialText: number,
                  hintText: 'Contact number',
                  width: kTextFieldWidth,
                  onChanged: (s) {
                    provider.onChanged(s, attribute: Attribute.patientNumber);
                  },
                );
              },
            ),
            SizedBox(
              width: 380,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Selector<NewDetailsProvider, int?>(
                    selector: (c, p) => p.patient.age,
                    builder: (ctx, age, child) {
                      return MyField(
                        initialText: age?.toString(),
                        hintText: 'Age',
                        width: 170,
                        onChanged: (s) {
                          provider.onChanged(s,
                              attribute: Attribute.patientAge);
                        },
                      );
                    },
                  ),
                  Selector<NewDetailsProvider, String?>(
                    selector: (c, p) => p.patient.gender,
                    builder: (ctx, gender, child) {
                      return const MyDropdownButton(
                        width: 190,
                        text: 'Gender',
                        textColor: kDarkGrayColor,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            AddBlock(
              heading: 'Contact person',
              children: [
                Selector<NewDetailsProvider, String?>(
                  selector: (c, p) => p.patient.contactPersonName,
                  builder: (ctx, name, child) {
                    return MyField(
                      initialText: name,
                      hintText: 'Name',
                      width: kTextFieldWidth,
                      onChanged: (s) {
                        provider.onChanged(s, attribute: Attribute.contactName);
                      },
                    );
                  },
                ),
                Selector<NewDetailsProvider, String?>(
                  selector: (c, p) => p.patient.contactPersonRelation,
                  builder: (ctx, relation, child) {
                    return MyField(
                      initialText: relation,
                      hintText: 'Relation with patient',
                      width: kTextFieldWidth,
                      onChanged: (s) {
                        provider.onChanged(s,
                            attribute: Attribute.contactRelation);
                      },
                    );
                  },
                ),
                Selector<NewDetailsProvider, String?>(
                  selector: (c, p) => p.patient.contactPersonNumber,
                  builder: (ctx, number, child) {
                    return MyField(
                      initialText: number,
                      hintText: 'Contact number',
                      width: kTextFieldWidth,
                      onChanged: (s) {
                        provider.onChanged(s,
                            attribute: Attribute.contactNumber);
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 110)
          ],
        ),
      ]),
    );
  }
}
