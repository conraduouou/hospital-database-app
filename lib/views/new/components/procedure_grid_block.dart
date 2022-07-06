import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/components/add_block.dart';
import 'package:hospital_database_app/components/custom_dropdown.dart';
import 'package:hospital_database_app/components/custom_field.dart';
import 'package:hospital_database_app/constants.dart';

class ProcedureGridBlock extends StatelessWidget {
  const ProcedureGridBlock({
    Key? key,
    required this.crossFadeState,
    this.showClose = false,
    required this.heading,
    required this.id,
    this.name,
    this.cost,
    this.onClose,
    this.addOnTap,
  }) : super(key: key);

  final CrossFadeState crossFadeState;
  final bool showClose;
  final String heading;
  final String id;
  final String? name;
  final String? cost;
  final VoidCallback? onClose;
  final VoidCallback? addOnTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: crossFadeState,
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
            CustomDropdown(
              text: id,
              color: kLightGrayColor,
              textColor: kDarkGrayColor,
              enabled: false,
              width: kTextFieldWidth,
            ),
            CustomField(
              initialText: name,
              hintText: 'Name',
              width: kTextFieldWidth,
            ),
            CustomField(
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
