import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:provider/provider.dart';

class ProcedureGridBlock extends StatelessWidget {
  const ProcedureGridBlock({
    Key? key,
    required this.showFirst,
    required this.heading,
    required this.id,
    required this.index,
    this.isNew = false,
    this.showClose = false,
    this.name,
    this.cost,
    this.onClose,
    this.addOnTap,
  }) : super(key: key);

  /// Tells which child to show.
  final bool showFirst;
  final bool showClose;
  final String heading;
  final String id;
  final bool isNew;
  final String? name;
  final String? cost;
  final VoidCallback? onClose;
  final VoidCallback? addOnTap;

  /// Supplied in order to track which procedure in the state list this widget
  /// corresponds to.
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 200),
      layoutBuilder: (firstChild, firstKey, secondChild, secondKey) {
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              key: secondKey,
              child: secondChild,
            ),
            Align(
              alignment: Alignment.centerLeft,
              key: firstKey,
              child: firstChild,
            ),
          ],
        );
      },
      firstChild: SizedBox(
        height: 350,
        child: AddBlock(
          heading: heading,
          showClose: showClose,
          onClose: onClose,
          children: [
            Selector<NewDetailsProvider, String?>(
              selector: (c, p) =>
                  index == p.procedures.length ? null : p.procedures[index].id,
              builder: (ctx, id, child) {
                return MyDropdownButton(
                  showDropdown: !isNew,
                  text: id ?? '',
                  color: kLightGrayColor,
                  textColor: kDarkGrayColor,
                  enabled: true,
                  width: kTextFieldWidth,
                );
              },
            ),
            MyField(
              initialText: name,
              hintText: 'Name',
              width: kTextFieldWidth,
            ),
            MyField(
              initialText: cost.toString(),
              hintText: 'Cost',
              width: kTextFieldWidth,
            ),
          ],
        ),
      ),
      secondChild: SizedBox(
        width: kTextFieldWidth,
        child: Center(
          child: SizedBox(
            height: 160,
            child: InkWell(
              onTap: addOnTap,
              borderRadius: BorderRadius.circular(35),
              child: SvgPicture.asset(
                'assets/add.svg',
                height: 160,
                color: kPurpleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
