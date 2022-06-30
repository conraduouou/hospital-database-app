import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.gearOnTap,
    required this.addOnTap,
  }) : super(key: key);

  final VoidCallback gearOnTap;
  final VoidCallback addOnTap;

  @override
  // change height of app bar by adjusting the value
  // in the Size.fromHeight constructor
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
