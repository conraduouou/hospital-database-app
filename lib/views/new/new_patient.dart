import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_appbar.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class NewPatientScreen extends StatelessWidget {
  const NewPatientScreen({Key? key}) : super(key: key);

  static const id = '/new/patient';

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBarProvider>(
      builder: (ctx, provider, child) {
        return GestureDetector(
          onTap: provider.unshowOptions,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: MyAppBar(
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
                provider.shouldShowGearOptions =
                    !provider.shouldShowGearOptions;
              },
              addOnTap: () {
                provider.shouldShowAddOptions = !provider.shouldShowAddOptions;
              },
            ),
          ),
        );
      },
    );
  }
}
