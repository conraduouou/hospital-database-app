import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_dropdown.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:provider/provider.dart';

class GearDropdownItem extends StatelessWidget {
  const GearDropdownItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppBarProvider>();

    return Builder(
      builder: (ctx) {
        if (kDebugMode) {
          print('gear item $index built');
        }
        return MyDropdownItem(
          text: provider.gearItems[index].content,
          height: 45,
          isHoveredColor: kPurpleColor,
          padding: index == 0
              ? const EdgeInsets.only(top: 10)
              : const EdgeInsets.only(bottom: 10),
          onTap: () {
            provider.selectMenuItem(
              index,
              menuType: MenuType.gear,
            );
          },
        );
      },
    );
  }
}
