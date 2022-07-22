import 'package:flutter/material.dart';
import 'package:hospital_database_app/derived_components/cross_faded_wrapper.dart';
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
        Selector<NewDetailsProvider, bool>(
          selector: (c, p) => p.isGettingPatient,
          builder: (ctx, inAsync, child) {
            return CrossFadedWrapper(
              inAsync: inAsync,
              alignment: Alignment.centerLeft,
              loadingWidget: const Padding(
                padding: EdgeInsets.only(left: 170),
                child: CircularProgressIndicator(
                  color: kPurpleColor,
                ),
              ),
              child: Selector<NewDetailsProvider, bool>(
                selector: (c, p) => p.patient.isCompleteForNew,
                builder: (ctx, isComplete, child) {
                  return AddBlock(
                    showError: !isComplete && provider.hasPressed,
                    heading: isNew ? 'New Patient' : 'Patient',
                    children: [
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.patient.id,
                        builder: (ctx, id, child) {
                          return MyDropdownButton(
                            text: id ?? '',
                            textColor: id?.compareTo('New') == 0
                                ? kDarkGrayColor
                                : Colors.black,
                            showDropdown: !isNew,
                            width: kTextFieldWidth,
                            itemsHeading: 'Patient ID',
                            items: provider.patientIds,
                            overlayTap: (index) {
                              provider.onSelectItem(index,
                                  dropdownType: DropdownType.patient);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.patient.name,
                        builder: (ctx, name, child) {
                          return MyField(
                            enabled: !provider.patient.isExisting,
                            initialText: name,
                            hintText: 'Name',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.patientName);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.patient.address,
                        builder: (ctx, address, child) {
                          return MyField(
                            enabled: !provider.patient.isExisting,
                            initialText: address,
                            hintText: 'Address',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.patientAddress);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.patient.contactNumber,
                        builder: (ctx, number, child) {
                          return MyField(
                            enabled: !provider.patient.isExisting,
                            initialText: number,
                            hintText: 'Contact number',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.patientNumber);
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
                                  enabled: !provider.patient.isExisting,
                                  initialText: age?.toString(),
                                  hintText: 'Age',
                                  isDigitsOnly: true,
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
                                return MyDropdownButton(
                                  enabled: !provider.patient.isExisting,
                                  width: 190,
                                  text: gender ??
                                      'Choose', // is null at build time
                                  textColor: Colors.black,
                                  itemsHeading: 'Gender',
                                  items: provider.genders,
                                  overlayTap: (index) {
                                    provider.onSelectItem(index,
                                        dropdownType: DropdownType.gender);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Expanded(
              child: Selector<NewDetailsProvider, bool>(
                selector: (c, p) => p.isGettingPatient,
                builder: (ctx, inAsync, child) {
                  return CrossFadedWrapper(
                    inAsync: inAsync,
                    alignment: Alignment.centerLeft,
                    loadingWidget: const Padding(
                      padding: EdgeInsets.only(left: 170),
                      child: CircularProgressIndicator(
                        color: kPurpleColor,
                      ),
                    ),
                    child: AddBlock(
                      heading: 'Contact person',
                      children: [
                        Selector<NewDetailsProvider, String?>(
                          selector: (c, p) => p.patient.contactPersonName,
                          builder: (ctx, name, child) {
                            return MyField(
                              enabled: !provider.patient.isExisting,
                              initialText: name,
                              hintText: 'Name',
                              width: kTextFieldWidth,
                              onChanged: (s) {
                                provider.onChanged(s,
                                    attribute: Attribute.contactName);
                              },
                            );
                          },
                        ),
                        Selector<NewDetailsProvider, String?>(
                          selector: (c, p) => p.patient.contactPersonRelation,
                          builder: (ctx, relation, child) {
                            return MyField(
                              enabled: !provider.patient.isExisting,
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
                              enabled: !provider.patient.isExisting,
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
                  );
                },
              ),
            ),
            const SizedBox(height: 110)
          ],
        ),
      ]),
    );
  }
}
