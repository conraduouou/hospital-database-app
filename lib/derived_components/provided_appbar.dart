import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_appbar.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class ProvidedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProvidedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  // change height of app bar by adjusting the value
  // in the Size.fromHeight constructor
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppBarProvider>();

    return MyAppBar(
      isHome: provider.isHome,
      leadingOnPressed: () {
        provider.deselectAddItems();
        provider.unshowOptions();

        Navigator.popUntil(
          context,
          ModalRoute.withName(HomeScreen.id),
        );
      },
      gearOnTap: () {
        provider.shouldShowGearOptions = !provider.shouldShowGearOptions;
      },
      addOnTap: () {
        provider.shouldShowAddOptions = !provider.shouldShowAddOptions;
      },
    );
  }
}
