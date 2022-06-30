import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/animated_menu.dart';
import 'package:hospital_database_app/components/custom_appbar.dart';
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
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
          ],
        ),
      ),
    );
  }
}
