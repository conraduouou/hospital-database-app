import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/my_table.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();

    if (kDebugMode) {
      print('body built');
    }

    return Stack(
      children: [
        Selector<HomeProvider, bool>(
          selector: (ctx, provider) => provider.isOpened,
          builder: (ctx, isOpened, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart,
              left: !isOpened ? 95 : 300,
              top: 90,
              child: Row(
                children: [
                  Text(
                    heading,
                    style: kXBoldStyle.copyWith(fontSize: 40),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/add.svg',
                    height: 34,
                  )
                ],
              ),
            );
          },
        ),
        Positioned(
          right: 337,
          top: 94,
          child: SvgPicture.asset(
            'assets/search.svg',
            height: 40,
          ),
        ),
        Selector<HomeProvider, String>(
            selector: (ctx, provider) => provider.sortText,
            builder: (ctx, sortText, child) {
              return Positioned(
                right: 92,
                top: 88,
                child: MyDropdownButton(
                  text: sortText.isEmpty ? 'Sort by' : sortText,
                  textColor: sortText.isEmpty ? kDarkGrayColor : null,
                ),
              );
            }),
        Selector<HomeProvider, bool>(
          selector: (ctx, provider) => provider.isOpened,
          builder: (ctx, isOpened, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuart,
              left: !isOpened ? 90 : 300,
              top: 170,
              child: MyTable(
                headers: provider.headers.where((h) => h.shouldShow).toList(),
                bodyRows: provider.bodyRows,
                provider: provider,
                isOpened: isOpened,
                tableType: provider.headingType,
              ),
            );
          },
        ),
      ],
    );
  }
}
