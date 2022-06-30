import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/add_dropdown.dart';
import 'package:hospital_database_app/components/animated_menu.dart';
import 'package:hospital_database_app/components/custom_appbar.dart';
import 'package:hospital_database_app/components/gear_dropdown.dart';
import 'package:hospital_database_app/constants.dart';
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
      child: Consumer<HomeProvider>(
        builder: (ctx, provider, child) {
          return GestureDetector(
            onTap: () {
              provider.shouldShowGearOptions = false;
              provider.shouldShowAddOptions = false;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomAppBar(
                addOnTap: () {
                  provider.shouldShowAddOptions =
                      !provider.shouldShowAddOptions;
                },
                gearOnTap: () {
                  provider.shouldShowGearOptions =
                      !provider.shouldShowGearOptions;
                },
              ),
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  const AdmissionsBody(),
                  Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      return AnimatedMenu(
                        isOpened: provider.isOpened,
                        onPressed: () {
                          if (provider.isOpened) {
                            provider.showColumns([3, 4]);
                          } else {
                            provider.hideColumns([3, 4]);
                          }
                          provider.toggleOpened();
                        },
                      );
                    },
                  ),
                  AnimatedPositioned(
                    top: provider.shouldShowAddOptions ? 0 : -250,
                    right: 50,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: const AddDropdown(),
                  ),
                  AnimatedPositioned(
                    top: provider.shouldShowGearOptions ? 0 : -200,
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
