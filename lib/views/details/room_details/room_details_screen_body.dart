import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_details_block.dart';
import 'package:hospital_database_app/components/my_error_widget.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/cross_faded_wrapper.dart';
import 'package:hospital_database_app/models/core/room_details.dart';
import 'package:hospital_database_app/providers/details_provider.dart';
import 'package:hospital_database_app/derived_components/details_body.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreenBody extends StatelessWidget {
  const RoomDetailsScreenBody({
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
                    final details = provider.details! as RoomDetails;
                    return DetailsBody(
                      provider: provider,
                      extraDataHeading: 'Currently housed patients',
                      extraDataTableType: TableType.patients,
                      blockRows: [
                        [
                          MyDetailsBlock(
                            details: details.room,
                            heading: 'Room Details',
                            showEdit: true,
                            lastIsFour: true,
                          )
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
