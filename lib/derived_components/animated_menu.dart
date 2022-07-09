import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_side_menu.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class AnimatedMenu extends StatelessWidget {
  const AnimatedMenu({
    Key? key,
  }) : super(key: key);

  // sizes
  static const bigRectangleHeight = 320.0;
  static const bigRectangleWidth = 280.0;
  static const smallRectangleHeight = 64.0;
  static const smallRectangleWidth = 58.0;

  // positions
  static const left = -bigRectangleWidth;
  static const top = 150.0;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    final appBarProvider = context.read<AppBarProvider>();

    return Selector<HomeProvider, bool>(
      selector: (ctx, provider) => provider.isOpened,
      builder: (ctx, isOpened, child) {
        if (kDebugMode) {
          print('menu built');
        }

        return MySideMenu(
          isOpened: isOpened,
          bigRectangleHeight: bigRectangleHeight,
          bigRectangleWidth: bigRectangleWidth,
          smallRectangleHeight: smallRectangleHeight,
          smallRectangleWidth: smallRectangleWidth,
          smallRectangleOnTap: () {
            appBarProvider.unshowOptions();
            if (provider.isOpened) {
              provider.showColumns([3, 4]);
            } else {
              provider.hideColumns([3, 4]);
            }
            provider.toggleOpened();
          },
          children: [
            ...(() {
              final list = <Widget>[];
              final homeProvider = context.read<HomeProvider>();
              final appBarProvider = context.read<AppBarProvider>();

              for (int i = 0; i < homeProvider.menuItems.length; i++) {
                list.add(
                  Selector<HomeProvider, bool>(
                    selector: (ctx, provider) =>
                        provider.menuItems[i].isSelected,
                    builder: (ctx, isSelected, child) {
                      if (kDebugMode) {
                        print('menu item $i built');
                      }

                      return MySideMenuItem(
                        height: 50,
                        isSelected: isSelected,
                        text: provider.menuItems[i].content,
                        onTap: () {
                          appBarProvider.unshowOptions();
                          provider.selectMenuItem(i);
                        },
                      );
                    },
                  ),
                );
              }

              return list;
            })()
          ],
        );
      },
    );
  }
}
