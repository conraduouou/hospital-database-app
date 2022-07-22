import 'package:flutter/material.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AdmissionRow extends StatelessWidget {
  const AdmissionRow({
    Key? key,
    this.isNew = true,
  }) : super(key: key);

  final bool isNew;

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
            Selector<NewDetailsProvider, DateTime?>(
              selector: (c, p) => p.admission.admissionDate,
              builder: (ctx, date, child) {
                return MyDropdownButton(
                  enabled: !isNew,
                  showDropdown: !isNew,
                  text: isNew
                      ? DateFormat.yMd().format(DateTime.now())
                      : date != null
                          ? DateFormat.yMd().format(date)
                          : 'Choose..',
                  textColor:
                      isNew || date == null ? kDarkGrayColor : Colors.black,
                  width: kTextFieldWidth,
                  itemsHeading: !isNew ? 'Date' : null,
                  items: !isNew ? provider.dates : null,
                  overlayTap: !isNew
                      ? (index) {
                          provider.onSelectItem(index,
                              dropdownType: DropdownType.date);
                        }
                      : null,
                );
              },
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
