import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hospital_database_app/components/my_button.dart';
import 'package:hospital_database_app/components/my_error_widget.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/cross_faded_wrapper.dart';
import 'package:hospital_database_app/models/helpers/sql_api_helper.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const id = '/login';

  @override
  Widget build(BuildContext context) {
    // get stream from sqlApi
    final stream = context.read<SQLApiHelper>().sqlApi.streamController.stream;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StreamBuilder<bool>(
          stream: stream,
          builder: (context, snapshot) {
            return CrossFadedWrapper(
              inAsync: snapshot.data ?? true,
              child: Builder(
                builder: (bContext) {
                  if (snapshot.hasError) {
                    return const MyErrorWidget();
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/logo.svg'),
                      const SizedBox(height: 12),
                      Text(
                        'hospital database',
                        style: kBlackStyle.copyWith(fontSize: 40),
                      ),
                      const SizedBox(height: 10),
                      const MyField(
                        width: 400,
                        hintText: 'Username',
                      ),
                      const SizedBox(height: 15),
                      const MyField(
                        width: 400,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 60),
                      Consumer<AppBarProvider>(
                        builder: (ctx, provider, child) {
                          return MyButton(
                            text: 'Log in',
                            onPressed: () {
                              provider.isHome = true;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.id,
                                (route) => false,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
