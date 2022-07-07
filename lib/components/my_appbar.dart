import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/constants.dart';

// purposefully wrapped in a Hero widget to give the illusion of being
// persistent
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.isHome,
    required this.gearOnTap,
    required this.addOnTap,
    this.leadingOnPressed,
  }) : super(key: key);

  final bool isHome;
  final VoidCallback gearOnTap;
  final VoidCallback addOnTap;

  /// must not be null when isHome is false
  final VoidCallback? leadingOnPressed;

  @override
  // change height of app bar by adjusting the value
  // in the Size.fromHeight constructor
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('appbar built');
    }
    return Hero(
      tag: 'appBar',
      child: AppBar(
        leading: !isHome
            ? IconButton(
                icon: const BackButtonIcon(),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                color: Colors.white,
                onPressed: leadingOnPressed,
              )
            : null,
        toolbarHeight: 70,
        backgroundColor: kPurpleColor,
        centerTitle: false,
        title: Text(
          'Hello, User',
          style: kBlackStyle.copyWith(
            color: Colors.white,
            fontSize: kLargeSize,
          ),
        ),
        actions: [
          IconButton(
            onPressed: addOnTap,
            iconSize: 30,
            icon: SvgPicture.asset(
              'assets/add.svg',
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: gearOnTap,
            iconSize: 43,
            icon: SvgPicture.asset(
              'assets/gear.svg',
              color: Colors.white,
            ),
          )
        ],
        elevation: 0,
      ),
    );
  }
}
