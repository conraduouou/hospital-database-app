import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/constants.dart';

class MyDetailsBlock extends StatelessWidget {
  const MyDetailsBlock({
    Key? key,
    required this.details,
    required this.heading,
    this.shouldOverflowAtIndex,
    this.showEdit = false,
    this.lastIsFour = false,
  }) : super(key: key);

  final Map<String, String> details;
  final String heading;
  final int? shouldOverflowAtIndex;
  final bool showEdit;
  final bool lastIsFour;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              heading,
              style: kBoldStyle.copyWith(fontSize: kXLargeSize),
            ),
            const SizedBox(width: 20),
            showEdit
                ? SvgPicture.asset(
                    'assets/pencil.svg',
                    height: 35,
                    color: kPurpleColor,
                  )
                : Container()
          ],
        ),
        const SizedBox(height: 50),
        for (int i = 0;
            i < (lastIsFour ? details.length - 1 : details.length);
            i++)
          Column(
            children: [
              SizedBox(
                width: 510,
                child: i == details.length - 2 && lastIsFour
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            details.keys.toList()[i],
                            style: kBoldStyle.copyWith(
                              overflow: shouldOverflowAtIndex == i
                                  ? TextOverflow.ellipsis
                                  : null,
                              fontSize: kLargeSize - 6,
                              color: kDarkGrayColor,
                            ),
                          ),
                          Text(
                            details.values.toList()[i],
                            style: kBoldStyle.copyWith(
                              overflow: shouldOverflowAtIndex == i
                                  ? TextOverflow.ellipsis
                                  : null,
                              fontSize: kLargeSize - 6,
                            ),
                          ),
                          Text(
                            details.keys.toList()[i + 1],
                            style: kBoldStyle.copyWith(
                              overflow: shouldOverflowAtIndex == i
                                  ? TextOverflow.ellipsis
                                  : null,
                              fontSize: kLargeSize - 6,
                              color: kDarkGrayColor,
                            ),
                          ),
                          Text(
                            details.values.toList()[i + 1],
                            style: kBoldStyle.copyWith(
                              overflow: shouldOverflowAtIndex == i
                                  ? TextOverflow.ellipsis
                                  : null,
                              fontSize: kLargeSize - 6,
                            ),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            details.keys.toList()[i],
                            style: kBoldStyle.copyWith(
                              overflow: shouldOverflowAtIndex == i
                                  ? TextOverflow.ellipsis
                                  : null,
                              fontSize: kLargeSize - 6,
                              color: kDarkGrayColor,
                            ),
                          ),
                          SizedBox(
                            width: shouldOverflowAtIndex == i ? 350 : null,
                            child: FittedBox(
                              fit: shouldOverflowAtIndex == i
                                  ? BoxFit.scaleDown
                                  : BoxFit.contain,
                              child: Text(
                                details.values.toList()[i],
                                style: kBoldStyle.copyWith(
                                  overflow: shouldOverflowAtIndex == i
                                      ? TextOverflow.ellipsis
                                      : null,
                                  fontSize: kLargeSize - 6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              i != details.length - 1 || i != details.length - 2 && !lastIsFour
                  ? const SizedBox(height: 30)
                  : Container(),
            ],
          )
      ],
    );
  }
}
