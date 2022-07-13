import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_error_widget.dart';
import 'package:hospital_database_app/components/my_progress_indicator.dart';

class AnimatedDetailsBody extends StatelessWidget {
  const AnimatedDetailsBody({
    Key? key,
    required this.inAsync,
    this.loadingWidget,
    this.actualOrErrorWidget,
  }) : super(key: key);

  final bool inAsync;
  final Widget? loadingWidget;
  final Widget? actualOrErrorWidget;

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
              alignment: Alignment.center,
              key: secondKey,
              child: secondChild,
            ),
            Align(
              alignment: Alignment.center,
              key: firstKey,
              child: firstChild,
            ),
          ],
        );
      },
      duration: const Duration(milliseconds: 200),
      firstChild: loadingWidget ?? const MyProgressIndicator(),
      secondChild: actualOrErrorWidget ?? const MyErrorWidget(),
    );
  }
}
