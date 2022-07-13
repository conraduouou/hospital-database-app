import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_details_block.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/doctor_details.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/derived_components/details_body.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreenBody extends StatelessWidget {
  const DoctorDetailsScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsProvider>();
    final details = provider.detailsController as DoctorDetails;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DetailsBody(
          provider: provider,
          extraDataHeading: 'Admissions worked on',
          extraDataTableType: TableType.admissions,
          blockRows: [
            [
              MyDetailsBlock(
                details: details.doctor,
                heading: 'Doctor Details',
                showEdit: true,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
