import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_dropdown.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/views/new/new_admission.dart';
import 'package:provider/provider.dart';

class AddDropdownItem extends StatelessWidget {
  const AddDropdownItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppBarProvider>();

    return Selector<AppBarProvider, bool>(
      selector: (ctx, provider) => provider.addItems[index].isHovered,
      builder: (ctx, isHovered, child) {
        if (kDebugMode) {
          print('add item $index');
        }
        return Selector<AppBarProvider, bool>(
          selector: (ctx, provider) => provider.addItems[index].isSelected,
          builder: (ctx, isSelected, child) {
            return MyDropdownItem(
              text: provider.addItems[index].content,
              height:
                  index == 0 || index == provider.addItems.length - 1 ? 50 : 40,
              padding: index == 0
                  ? const EdgeInsets.only(top: 10)
                  : index == provider.addItems.length - 1
                      ? const EdgeInsets.only(bottom: 10)
                      : null,
              color: isHovered || isSelected ? kPurpleColor : null,
              onHover: (isHovered) {
                provider.hoverMenuItem(
                  index,
                  isHovered: isHovered,
                  menuType: MenuType.add,
                );
              },
              onTap: !isSelected
                  ? () {
                      provider.isHome = false;
                      provider.selectMenuItem(
                        index,
                        menuType: MenuType.add,
                      );

                      String id = NewAdmissionScreen.id;
                      try {
                        id = provider.addScreens[index];
                      } on RangeError {
                        id = NewAdmissionScreen.id;
                      } finally {
                        Navigator.pushNamed(context, id);
                      }
                    }
                  : () {},
            );
          },
        );
      },
    );
  }
}
