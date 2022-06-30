import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:provider/provider.dart';

class AnimatedMenu extends StatelessWidget {
  const AnimatedMenu({
    Key? key,
    required this.isOpened,
    required this.onPressed,
  }) : super(key: key);

  // sizes
  static const bigRectangleHeight = 320.0;
  static const bigRectangleWidth = 280.0;
  static const smallRectangleHeight = 64.0;
  static const smallRectangleWidth = 58.0;

  // positions
  static const left = -bigRectangleWidth;
  static const top = 150.0;

  final bool isOpened;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutQuart,
      left: isOpened ? -50 : left,
      top: top,
      height: bigRectangleHeight,
      width: bigRectangleWidth + smallRectangleWidth / 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: bigRectangleHeight,
            width: bigRectangleWidth,
            decoration: BoxDecoration(
              color: kPurpleColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Consumer<HomeProvider>(
                builder: (ctx, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < provider.menuItems.length; i++)
                        InkWell(
                          onTap: () => provider.selectMenuItem(i),
                          child: Text(
                            provider.menuItems[i].content,
                            style: kXBoldStyle.copyWith(
                              color: Colors.white,
                              fontSize: kLargeSize - 4,
                              decoration: provider.menuItems[i].isSelected
                                  ? TextDecoration.underline
                                  : null,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: bigRectangleWidth - smallRectangleWidth / 2,
            top: bigRectangleHeight / 2 - smallRectangleHeight / 2,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                height: smallRectangleHeight,
                width: smallRectangleWidth,
                decoration: BoxDecoration(
                  color: kPurpleColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
