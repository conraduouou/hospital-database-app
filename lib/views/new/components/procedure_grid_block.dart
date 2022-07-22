import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/constants.dart';

class ProcedureGridBlock extends StatelessWidget {
  const ProcedureGridBlock({
    Key? key,
    required this.showFirst,
    required this.heading,
    required this.children,
    this.inAsync = false,
    this.showClose = false,
    this.showError = false,
    this.onClose,
    this.addOnTap,
  }) : super(key: key);

  /// Tells which child to show.
  final bool showFirst;
  final bool inAsync;
  final String heading;
  final List<Widget> children;
  final bool showClose;
  final bool showError;
  final VoidCallback? onClose;
  final VoidCallback? addOnTap;

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
          showError: showError,
          heading: heading,
          showClose: showClose,
          onClose: onClose,
          children: children,
        ),
      ),
      secondChild: inAsync
          ? const Padding(
              padding: EdgeInsets.only(left: 170),
              child: CircularProgressIndicator(
                color: kPurpleColor,
              ),
            )
          : SizedBox(
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
