import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class MyTableCell extends StatefulWidget {
  const MyTableCell({
    Key? key,
    required this.content,
    this.isSelected = false,
    this.padding,
    this.height,
    this.width,
    this.textColor,
    this.hoverColor,
    this.onTap,
  }) : super(key: key);

  final String content;
  final bool isSelected;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? hoverColor;
  final VoidCallback? onTap;

  @override
  State<MyTableCell> createState() => _MyTableCellState();
}

class _MyTableCellState extends State<MyTableCell> {
  late Color currentColor;

  @override
  void initState() {
    currentColor = widget.isSelected
        ? widget.hoverColor ?? kPurpleColor
        : widget.textColor ?? Colors.white;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyTableCell oldWidget) {
    currentColor = widget.isSelected
        ? widget.hoverColor ?? kPurpleColor
        : widget.textColor ?? Colors.white;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.padding ?? const EdgeInsets.only(right: 10),
      alignment: Alignment.centerLeft,
      child: InkWell(
        onHover: (isHovered) {
          setState(() {
            currentColor = isHovered || widget.isSelected
                ? widget.hoverColor ?? kPurpleColor
                : widget.textColor ?? Colors.white;
          });
        },
        onTap: () {
          if (widget.onTap != null) {
            setState(() {
              currentColor = widget.isSelected
                  ? widget.hoverColor ?? kPurpleColor
                  : widget.textColor ?? Colors.white;
            });
            widget.onTap!();
          }
        },
        child: Text(
          widget.content,
          overflow: TextOverflow.ellipsis,
          style: kBoldStyle.copyWith(
            color: currentColor,
            fontSize: kRegularSize,
          ),
        ),
      ),
    );
  }
}
