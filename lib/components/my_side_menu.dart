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
    this.isOpened = false,
  }) : super(key: key);

  final double bigRectangleWidth;
  final double smallRectangleWidth;
  final double bigRectangleHeight;
  final double smallRectangleHeight;

  final VoidCallback? smallRectangleOnTap;
  final Color? bigRectangleColor;
  final Color? smallRectangleColor;

  final bool isOpened;

  /// Typically MySideMenuItem(s)
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutQuart,
      left: isOpened ? -50 : -bigRectangleWidth,
      top: 150,
      height: bigRectangleHeight,
      width: bigRectangleWidth + smallRectangleWidth / 2,
      child: Stack(
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
      ),
    );
  }
}

class MySideMenuItem extends StatefulWidget {
  const MySideMenuItem({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.isHoveredColor,
    this.color,
  }) : super(key: key);

  final bool isSelected;
  final String text;
  final double? height;
  final double? width;
  final Color? isHoveredColor;
  final Color? color;

  final VoidCallback onTap;

  @override
  State<MySideMenuItem> createState() => _MySideMenuItemState();
}

class _MySideMenuItemState extends State<MySideMenuItem> {
  late Color? currentColor;

  @override
  void initState() {
    currentColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (isHovered) {
        setState(() {
          currentColor = isHovered
              ? widget.isHoveredColor ?? kDarkPurpleColor
              : widget.color;
        });
      },
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: currentColor,
        child: Row(
          children: [
            const SizedBox(width: 70),
            Text(
              widget.text,
              style: kXBoldStyle.copyWith(
                color: Colors.white,
                fontSize: kLargeSize - 4,
                decoration: widget.isSelected ? TextDecoration.underline : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
