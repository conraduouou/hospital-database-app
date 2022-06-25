import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.width,
    this.radius,
    this.color,
    this.hintText,
  }) : super(key: key);

  final double width;
  final double? radius;
  final Color? color;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        style: kBoldStyle.copyWith(fontSize: kRegularSize),
        cursorColor: kPurpleColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: color ?? kOffWhiteColor,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: kGrayBoldStyle.copyWith(fontSize: kRegularSize),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
        ),
      ),
    );
  }
}
