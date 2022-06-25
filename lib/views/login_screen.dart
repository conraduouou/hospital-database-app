import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/components/custom_button.dart';
import 'package:hospital_database_app/components/custom_field.dart';
import 'package:hospital_database_app/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const id = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logo.svg'),
            const SizedBox(height: 12),
            Text(
              'hospital database',
              style: kBlackStyle.copyWith(fontSize: 40),
            ),
            const SizedBox(height: 10),
            const CustomField(
              width: 400,
              hintText: 'Username',
            ),
            const SizedBox(height: 15),
            const CustomField(
              width: 400,
              hintText: 'Password',
            ),
            const SizedBox(height: 60),
            const CustomButton(text: 'Log in'),
          ],
        ),
      ),
    );
  }
}
