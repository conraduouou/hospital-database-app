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

    return Selector<AppBarProvider, bool>(
      selector: (ctx, provider) => provider.gearItems[index].isHovered,
      builder: (ctx, isHovered, child) {
        if (kDebugMode) {
          print('gear item $index built');
        }
        return MyDropdownItem(
          text: provider.gearItems[index].content,
          height: 45,
          color: isHovered ? kPurpleColor : null,
          padding: index == 0
              ? const EdgeInsets.only(top: 10)
              : const EdgeInsets.only(bottom: 10),
          onHover: (isHovered) {
            provider.hoverMenuItem(
              index,
              isHovered: isHovered,
              menuType: MenuType.gear,
            );
          },
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
