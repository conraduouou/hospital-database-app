import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/models/helpers/sql_api_helper.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/views/details/doctor_details/doctor_details_screen_body.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  static const id = '/details/doctor';
  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final appBarProvider = context.read<AppBarProvider>();
    final helper = context.read<SQLApiHelper>();

    return ChangeNotifierProvider(
      create: (context) => DetailsProvider(
        tableType: TableType.doctors,
        id: doctorId,
        helper: helper,
      ),
      child: GestureDetector(
        onTap: appBarProvider.unshowOptions,
        child: Scaffold(
          appBar: const ProvidedAppBar(isHome: false),
          backgroundColor: Colors.white,
          body: Stack(
            clipBehavior: Clip.none,
            children: const [
              DoctorDetailsScreenBody(),
              AppBarOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
