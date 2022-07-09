import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class MyDropdown extends StatelessWidget {
  const MyDropdown({
    Key? key,
    required this.shouldShowOptions,
    required this.children,
    this.height,
    this.width,
  }) : super(key: key);

  final double? height;
  final double? width;
  final bool shouldShowOptions;

  /// The items for the add dropdown. Typically sized 240x(50 or 40), with 50
  /// as the first and last child. The first child should have a top padding of
  /// 10 and the last child should have a bottom padding of 10 as well to
  /// achieve desired look.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('add built');
    }
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Container(
        height: height ?? 220,
        width: width ?? 240,
        color: kDarkPurpleColor,
        child: FocusTraversalGroup(
          descendantsAreFocusable: shouldShowOptions,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}

class MyDropdownItem extends StatefulWidget {
  const MyDropdownItem({
    Key? key,
    required this.text,
    required this.onTap,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.isHoveredColor,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final Color? color;
  final Color? isHoveredColor;

  @override
  State<MyDropdownItem> createState() => _MyDropdownItemState();
}

class _MyDropdownItemState extends State<MyDropdownItem> {
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
          currentColor =
              isHovered ? widget.isHoveredColor ?? kPurpleColor : widget.color;
        });
      },
      onTap: widget.onTap,
      child: Container(
        height: widget.height ?? 40,
        width: 240,
        padding: widget.padding,
        color: currentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.text,
              style: kBoldStyle.copyWith(
                color: Colors.white,
                fontSize: kRegularSize,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
