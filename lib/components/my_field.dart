import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital_database_app/constants.dart';

class MyField extends StatefulWidget {
  const MyField({
    Key? key,
    this.width,
    this.radius,
    this.color,
    this.initialText,
    this.hintText,
    this.enabled = true,
    this.isDigitsOnly = false,
    this.onChanged,
  }) : super(key: key);

  final double? width;
  final double? radius;
  final Color? color;
  final String? initialText;
  final String? hintText;
  final bool enabled;
  final bool isDigitsOnly;
  final void Function(String)? onChanged;

  @override
  State<MyField> createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        inputFormatters: widget.isDigitsOnly
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        controller: _controller,
        style: kBoldStyle.copyWith(fontSize: kRegularSize),
        cursorColor: kPurpleColor,
        onChanged: widget.onChanged,
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
