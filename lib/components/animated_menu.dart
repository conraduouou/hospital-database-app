import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
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
    print('menu built');
    return Consumer<HomeProvider>(
      builder: (ctx, provider, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutQuart,
          left: provider.isOpened ? -50 : left,
          top: top,
          height: bigRectangleHeight,
          width: bigRectangleWidth + smallRectangleWidth / 2,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: bigRectangleWidth - smallRectangleWidth / 2,
                top: bigRectangleHeight / 2 - smallRectangleHeight / 2,
                child: Consumer<AppBarProvider>(
                  builder: (ctx2, appBarProvider, child) {
                    return GestureDetector(
                      onTap: () {
                        appBarProvider.unshowOptions();

                        if (provider.isOpened) {
                          provider.showColumns([3, 4]);
                        } else {
                          provider.hideColumns([3, 4]);
                        }

                        provider.toggleOpened();
                      },
                      child: Container(
                        height: smallRectangleHeight,
                        width: smallRectangleWidth,
                        decoration: BoxDecoration(
                          color: kPurpleColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: bigRectangleHeight,
                width: bigRectangleWidth,
                decoration: BoxDecoration(
                  color: kPurpleColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 35),
                    for (int i = 0; i < provider.menuItems.length; i++)
                      Consumer<AppBarProvider>(
                        builder: (ctx2, appBarProvider, child) {
                          return InkWell(
                            onHover: (isHovered) {
                              provider.hoverMenuItem(i, isHovered: isHovered);
                            },
                            onTap: () {
                              appBarProvider.unshowOptions();
                              provider.selectMenuItem(i);
                            },
                            child: Container(
                              width: bigRectangleWidth,
                              height: 50,
                              color: provider.menuItems[i].isHovered
                                  ? kDarkPurpleColor
                                  : null,
                              child: Row(
                                children: [
                                  const SizedBox(width: 70),
                                  Text(
                                    provider.menuItems[i].content,
                                    style: kXBoldStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: kLargeSize - 4,
                                      decoration:
                                          provider.menuItems[i].isSelected
                                              ? TextDecoration.underline
                                              : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
