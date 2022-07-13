import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_details_block.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/derived_components/details_body.dart';
import 'package:provider/provider.dart';

class AdmissionDetailsScreenBody extends StatelessWidget {
  const AdmissionDetailsScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsProvider>();
    final details = provider.details as AdmissionDetails;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DetailsBody(
          provider: provider,
          extraDataHeading: 'Procedures',
          extraDataTableType: TableType.procedures,
          blockRows: [
            [
              MyDetailsBlock(
                details: details.admission,
                heading: 'Admission Details',
                showEdit: true,
              ),
              MyDetailsBlock(
                details: details.transaction,
                heading: 'Transactions',
              ),
            ],
            [
              MyDetailsBlock(
                details: details.patient,
                heading: 'Patient',
                lastIsFour: true,
              ),
              MyDetailsBlock(
                details: details.doctor,
                heading: 'Doctor',
              ),
            ],
            [
              MyDetailsBlock(
                details: details.room,
                heading: 'Room',
              ),
            ],
          ],
        ),
      ],
    );
  }
}