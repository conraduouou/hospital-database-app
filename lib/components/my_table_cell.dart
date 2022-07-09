import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class MyTableCell extends StatefulWidget {
  const MyTableCell({
    Key? key,
    required this.content,
    this.height,
    this.width,
    this.textColor,
    this.hoverColor,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String content;
  final bool isSelected;
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
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    currentColor = isSelected
        ? widget.hoverColor ?? kPurpleColor
        : widget.textColor ?? Colors.white;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyTableCell oldWidget) {
    isSelected = widget.isSelected;
    currentColor = isSelected
        ? widget.hoverColor ?? kPurpleColor
        : widget.textColor ?? Colors.white;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('${widget.content} cell with status ${widget.isSelected} built.');
    }
    return Container(
      height: widget.height,
      width: widget.width,
      alignment: Alignment.centerLeft,
      child: InkWell(
        onHover: (isHovered) {
          setState(() {
            currentColor = isHovered || isSelected
                ? widget.hoverColor ?? kPurpleColor
                : widget.textColor ?? Colors.white;
          });
        },
        onTap: () {
          setState(() {
            isSelected = !isSelected;

            currentColor = isSelected
                ? widget.hoverColor ?? kPurpleColor
                : widget.textColor ?? Colors.white;
          });

          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: Text(
          widget.content,
          style: kBoldStyle.copyWith(
            color: currentColor,
            fontSize: kRegularSize,
          ),
        ),
      ),
    );
  }
}
