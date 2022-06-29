import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class AnimatedMenu extends StatefulWidget {
  const AnimatedMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedMenu> createState() => _AnimatedMenuState();
}

class _AnimatedMenuState extends State<AnimatedMenu> {
  // sizes
  static const bigRectangleHeight = 320.0;
  static const bigRectangleWidth = 280.0;
  static const smallRectangleHeight = 64.0;
  static const smallRectangleWidth = 58.0;

  // positions
  static const left = -bigRectangleWidth;
  static const top = 150.0;

  bool _isOpened = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutQuart,
      left: _isOpened ? -50 : left,
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
          ),
          Positioned(
            left: bigRectangleWidth - (smallRectangleWidth / 2),
            top: (bigRectangleHeight / 2) - (smallRectangleHeight / 2),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isOpened = !_isOpened;
                });
              },
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
