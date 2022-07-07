import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/constants.dart';

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({
    Key? key,
    required this.text,
    this.onTap,
    this.onHover,
    this.color,
    this.textColor,
    this.hoverColor,
    this.enabled = true,
    this.showDropdown = true,
    this.width,
  }) : super(key: key);

  final String text;
  final Color? color;
  final Color? hoverColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onHover;
  final bool enabled;
  final bool showDropdown;
  final double? width;

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enabled ? widget.onTap ?? () {} : null,
      onHover: (isHovered) {
        setState(() {
          _isHovered = isHovered;
        });

        if (widget.onHover != null) {
          widget.onHover!();
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: widget.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: _isHovered && widget.enabled
              ? widget.hoverColor ?? kGrayColor
              : widget.color ?? kLightGrayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: kBoldStyle.copyWith(
                fontSize: kRegularSize,
                color: widget.textColor ?? Colors.black,
              ),
            ),
            widget.showDropdown
                ? SvgPicture.asset(
                    'assets/dropdown.svg',
                    color: kDarkGrayColor,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
