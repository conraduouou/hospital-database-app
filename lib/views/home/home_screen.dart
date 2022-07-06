import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/add_dropdown.dart';
import 'package:hospital_database_app/components/animated_menu.dart';
import 'package:hospital_database_app/components/custom_appbar.dart';
import 'package:hospital_database_app/components/gear_dropdown.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:hospital_database_app/views/home/admissions_body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const id = '/home';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<AppBarProvider>(
        builder: (ctx, appBarProvider, child) {
          return GestureDetector(
            onTap: appBarProvider.unshowOptions,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                addOnTap: () {
                  appBarProvider.shouldShowAddOptions =
                      !appBarProvider.shouldShowAddOptions;
                },
                gearOnTap: () {
                  appBarProvider.shouldShowGearOptions =
                      !appBarProvider.shouldShowGearOptions;
                },
              ),
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  const AdmissionsBody(),
                  const AnimatedMenu(),
                  AnimatedPositioned(
                    top: appBarProvider.shouldShowAddOptions ? 0 : -250,
                    right: 50,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: const AddDropdown(),
                  ),
                  AnimatedPositioned(
                    top: appBarProvider.shouldShowGearOptions ? 0 : -200,
                    right: 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: const GearDropdown(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
