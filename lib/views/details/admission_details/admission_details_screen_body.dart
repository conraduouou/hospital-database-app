import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_details_block.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/my_table.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:provider/provider.dart';

class AdmissionDetailsScreenBody extends StatelessWidget {
  const AdmissionDetailsScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DetailsProvider>();
    final details = provider.details;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 90.0, top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyDetailsBlock(
                      details: details.admission,
                      heading: 'Admission Details',
                      showEdit: true,
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    MyDetailsBlock(
                      details: details.transaction,
                      heading: 'Transactions',
                    ),
                  ],
                ),
                const SizedBox(height: 120),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyDetailsBlock(
                      details: details.patient,
                      heading: 'Patient',
                      lastIsFour: true,
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    MyDetailsBlock(
                      details: details.doctor,
                      heading: 'Doctor',
                    ),
                  ],
                ),
                const SizedBox(height: 120),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyDetailsBlock(
                      details: details.room,
                      heading: 'Room',
                    ),
                  ],
                ),
                const SizedBox(height: 120),
                //TODO: Make procedures table
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Procedures',
                      style: kBoldStyle.copyWith(fontSize: kXLargeSize),
                    ),
                    const SizedBox(height: 30),
                    Builder(
                      builder: (context) {
                        final provider = context.read<DetailsProvider>();
                        return SizedBox(
                          width: 1140,
                          child: MyTable(
                            isAnimated: false,
                            bodyRows: provider.bodyRows,
                            headers: provider.headers,
                            provider: provider,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
