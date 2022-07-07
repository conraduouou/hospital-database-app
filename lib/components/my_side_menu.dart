import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class MySideMenu extends StatelessWidget {
  const MySideMenu({
    Key? key,
    required this.bigRectangleWidth,
    required this.smallRectangleWidth,
    required this.bigRectangleHeight,
    required this.smallRectangleHeight,
    required this.children,
    this.smallRectangleOnTap,
    this.bigRectangleColor,
    this.smallRectangleColor,
  }) : super(key: key);

  final double bigRectangleWidth;
  final double smallRectangleWidth;
  final double bigRectangleHeight;
  final double smallRectangleHeight;

  final VoidCallback? smallRectangleOnTap;
  final Color? bigRectangleColor;
  final Color? smallRectangleColor;

  /// Typically MySideMenuItem(s)
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: bigRectangleWidth - smallRectangleWidth / 2,
          top: bigRectangleHeight / 2 - smallRectangleHeight / 2,
          child: InkWell(
            onTap: smallRectangleOnTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: smallRectangleHeight,
              width: smallRectangleWidth,
              decoration: BoxDecoration(
                color: smallRectangleColor ?? kPurpleColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        Container(
          height: bigRectangleHeight,
          width: bigRectangleWidth,
          decoration: BoxDecoration(
            color: bigRectangleColor ?? kPurpleColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              ...children,
            ],
          ),
        ),
      ],
    );
  }
}

class MySideMenuItem extends StatelessWidget {
  const MySideMenuItem({
    Key? key,
    required this.isHovered,
    required this.isSelected,
    required this.text,
    required this.onHover,
    required this.onTap,
    this.width,
    this.height,
    this.isHoveredColor,
    this.color,
  }) : super(key: key);

  final bool isHovered;
  final bool isSelected;
  final String text;
  final double? height;
  final double? width;
  final Color? isHoveredColor;
  final Color? color;

  final void Function(bool) onHover;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: onHover,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        color: isHovered ? isHoveredColor ?? kDarkPurpleColor : color,
        child: Row(
          children: [
            const SizedBox(width: 70),
            Text(
              text,
              style: kXBoldStyle.copyWith(
                color: Colors.white,
                fontSize: kLargeSize - 4,
                decoration: isSelected ? TextDecoration.underline : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
