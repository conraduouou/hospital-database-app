import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hospital_database_app/components/my_details_block.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/my_table.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/views/details/admission_details/admission_details_screen_body.dart';
import 'package:provider/provider.dart';

class AdmissionDetailsScreen extends StatelessWidget {
  const AdmissionDetailsScreen({Key? key}) : super(key: key);

  static const id = '/details/admission';

  @override
  Widget build(BuildContext context) {
    final appBarProvider = context.read<AppBarProvider>();

    return ChangeNotifierProvider(
      create: (context) => DetailsProvider(),
      child: GestureDetector(
        onTap: appBarProvider.unshowOptions,
        child: Scaffold(
          appBar: const ProvidedAppBar(isHome: false),
          backgroundColor: Colors.white,
          body: Stack(
            clipBehavior: Clip.none,
            children: const [
              AdmissionDetailsScreenBody(),
              AppBarOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
