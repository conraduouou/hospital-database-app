import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class CustomField extends StatefulWidget {
  const CustomField({
    Key? key,
    this.width,
    this.radius,
    this.color,
    this.initialText,
    this.hintText,
    this.enabled = true,
  }) : super(key: key);

  final double? width;
  final double? radius;
  final Color? color;
  final String? initialText;
  final String? hintText;
  final bool enabled;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        style: kBoldStyle.copyWith(fontSize: kRegularSize),
        cursorColor: kPurpleColor,
        decoration: InputDecoration(
          enabled: widget.enabled,
          filled: true,
          fillColor: widget.color ?? kOffWhiteColor,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: kGrayBoldStyle.copyWith(fontSize: kRegularSize),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(widget.radius ?? 10),
          ),
        ),
      ),
    );
  }
}
