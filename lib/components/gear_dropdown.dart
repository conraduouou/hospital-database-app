import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';

import 'package:provider/provider.dart';

class GearDropdown extends StatelessWidget {
  const GearDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('gear built');
    return Consumer<AppBarProvider>(
      builder: (ctx, provider, child) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            height: 90,
            width: 240,
            color: kDarkPurpleColor,
            child: Column(
              children: [
                for (int i = 0; i < provider.gearItems.length; i++)
                  InkWell(
                    onHover: (isHovered) {
                      provider.hoverMenuItem(
                        i,
                        isHovered: isHovered,
                        menuType: MenuType.gear,
                      );
                    },
                    onTap: () {
                      provider.selectMenuItem(
                        i,
                        menuType: MenuType.gear,
                      );
                    },
                    child: Container(
                      width: 240,
                      height: 45,
                      padding: i == 0
                          ? const EdgeInsets.only(top: 10)
                          : const EdgeInsets.only(bottom: 10),
                      color:
                          provider.gearItems[i].isHovered ? kPurpleColor : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            provider.gearItems[i].content,
                            style: kBoldStyle.copyWith(
                              color: Colors.white,
                              fontSize: kRegularSize,
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
