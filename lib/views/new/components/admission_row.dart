import 'package:flutter/material.dart';
import 'package:hospital_database_app/derived_components/cross_faded_wrapper.dart';
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
        Selector<NewDetailsProvider, bool>(
          selector: (c, p) => p.admission.isCompleteForNew,
          builder: (ctx, isComplete, child) {
            return AddBlock(
              showError: !isComplete && provider.hasPressed,
              heading: 'New Admission',
              children: [
                const MyField(
                  enabled: false,
                  color: kLightGrayColor,
                  hintText: 'New',
                  width: kTextFieldWidth,
                ),
                Selector<NewDetailsProvider, DateTime?>(
                  selector: (c, p) => p.admission.admissionDate,
                  builder: (ctx, date, child) {
                    return MyDropdownButton(
                      text: date != null
                          ? DateFormat.yMd().format(date)
                          : 'Choose..',
                      textColor: date == null ? kDarkGrayColor : Colors.black,
                      width: kTextFieldWidth,
                      itemsHeading: 'Date',
                      items: provider.dates,
                      overlayTap: (index) {
                        provider.onSelectItem(index,
                            dropdownType: DropdownType.date);
                      },
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
            );
          },
        ),
      ]),
    );
  }
}
