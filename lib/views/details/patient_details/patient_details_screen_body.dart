import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_details_block.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/derived_components/details_body.dart';
import 'package:provider/provider.dart';

class PatientDetailsScreenBody extends StatelessWidget {
  const PatientDetailsScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsProvider>();
    final details = provider.detailsController as PatientDetails;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DetailsBody(
          provider: provider,
          extraDataHeading: 'Admissions',
          extraDataTableType: TableType.admissions,
          blockRows: [
            [
              MyDetailsBlock(
                details: details.patient,
                heading: 'Patient Record',
                showEdit: true,
                lastIsFour: true,
              ),
              MyDetailsBlock(
                details: details.contactPerson,
                heading: 'Contact Person',
              ),
            ],
          ],
        ),
      ],
    );
  }
}
