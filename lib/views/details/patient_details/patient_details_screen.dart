import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/views/details/patient_details/patient_details_screen_body.dart';
import 'package:provider/provider.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({Key? key}) : super(key: key);

  static const id = '/details/patient';

  @override
  Widget build(BuildContext context) {
    final appBarProvider = context.read<AppBarProvider>();

    return ChangeNotifierProvider(
      create: (context) => DetailsProvider(
        tableType: TableType.patients,
      ),
      child: GestureDetector(
        onTap: appBarProvider.unshowOptions,
        child: Scaffold(
          appBar: const ProvidedAppBar(isHome: false),
          backgroundColor: Colors.white,
          body: Stack(
            clipBehavior: Clip.none,
            children: const [
              PatientDetailsScreenBody(),
              AppBarOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
