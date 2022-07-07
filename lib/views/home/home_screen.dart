import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/derived_components/animated_menu.dart';
import 'package:hospital_database_app/components/my_appbar.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:hospital_database_app/views/home/admissions_body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const id = '/home';

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('home built');
    }

    final appBarProvider = context.read<AppBarProvider>();

    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: GestureDetector(
        onTap: appBarProvider.unshowOptions,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyAppBar(
            isHome: appBarProvider.isHome,
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
            children: const [
              AdmissionsBody(),
              AnimatedMenu(),
              AppBarOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
