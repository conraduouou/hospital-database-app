import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/animated_menu.dart';
import 'package:hospital_database_app/components/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const id = '/admissions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Stack(
        clipBehavior: Clip.none,
        children: const [
          AnimatedMenu(),
          Positioned(
            left: 300,
            top: 150,
            child: Text('hey'),
          ),
        ],
      ),
    );
  }
}
