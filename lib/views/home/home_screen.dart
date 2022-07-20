import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospital_database_app/derived_components/animated_menu.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/models/helpers/sql_api_helper.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/home_provider.dart';
import 'package:hospital_database_app/views/home/home_screen_body.dart';
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
    final apiHelper = context.read<SQLApiHelper>();

    return ChangeNotifierProvider(
      create: (context) => HomeProvider(apiHelper: apiHelper),
      child: GestureDetector(
        onTap: appBarProvider.unshowOptions,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: ProvidedAppBar(
            isHome: appBarProvider.isHome,
          ),
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Selector<HomeProvider, String>(
                selector: (ctx, provider) => provider.heading,
                builder: (ctx, heading, child) {
                  return HomeScreenBody(
                    heading: heading,
                  );
                },
              ),
              const AnimatedMenu(),
              const AppBarOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
