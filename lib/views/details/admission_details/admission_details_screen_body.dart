import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_details_block.dart';
import 'package:hospital_database_app/components/my_error_widget.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/cross_faded_wrapper.dart';
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Selector<DetailsProvider, bool>(
          selector: (ctx, provider) => provider.inAsync,
          builder: (ctx, inAsync, child) {
            return CrossFadedWrapper(
              inAsync: inAsync,
              child: Builder(
                builder: (context) {
                  if (provider.details == null) {
                    return const MyErrorWidget();
                  } else {
                    final details = provider.details! as AdmissionDetails;
                    return DetailsBody(
                      provider: provider,
                      extraDataHeading: 'Procedures',
                      extraDataTableType: TableType.procedures,
                      blockRows: [
                        [
                          MyDetailsBlock(
                            details: details.admissionDetails,
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
                            details: details.patientDetails,
                            heading: 'Patient',
                            lastIsFour: true,
                          ),
                          MyDetailsBlock(
                            details: details.doctorDetails,
                            heading: 'Doctor',
                          ),
                        ],
                        [
                          MyDetailsBlock(
                            details: details.roomDetails,
                            heading: 'Room',
                          ),
                        ],
                      ],
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
