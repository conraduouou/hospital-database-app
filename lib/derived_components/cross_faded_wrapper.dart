import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_error_widget.dart';
import 'package:hospital_database_app/components/my_progress_indicator.dart';

class CrossFadedWrapper extends StatelessWidget {
  const CrossFadedWrapper({
    Key? key,
    required this.inAsync,
    this.loadingWidget,
    this.child,
    this.alignment,
  }) : super(key: key);

  final bool inAsync;
  final Widget? loadingWidget;
  final Widget? child;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          inAsync ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      layoutBuilder: (firstChild, firstKey, secondChild, secondKey) {
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Align(
              alignment: alignment ?? Alignment.center,
              key: secondKey,
              child: secondChild,
            ),
            Align(
              alignment: alignment ?? Alignment.center,
              key: firstKey,
              child: firstChild,
            ),
          ],
        );
      },
      duration: const Duration(milliseconds: 200),
      firstChild: loadingWidget ?? const MyProgressIndicator(),
      secondChild: child ?? const MyErrorWidget(),
    );
  }
}
