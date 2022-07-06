import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';

class AddBlock extends StatelessWidget {
  const AddBlock({
    Key? key,
    required this.heading,
    required this.children,
    this.showClose = false,
    this.onClose,
  }) : super(key: key);

  final String heading;
  final List<Widget> children;
  final bool showClose;
  final VoidCallback? onClose;

  //TODO: Wrap AddBlock with that widget that directs the TAB keyboard input;
  // gotta watch that one flutter video again.

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                heading,
                style: kBoldStyle.copyWith(
                  fontSize: kXLargeSize,
                ),
              ),
              const SizedBox(width: 90),
              showClose
                  ? IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close),
                      color: Colors.red,
                    )
                  : Container()
            ],
          ),
          const SizedBox(height: 45),
          for (final child in children)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child,
                const SizedBox(height: 24),
              ],
            ),
        ],
      ),
    );
  }
}
