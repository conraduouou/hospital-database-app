import 'package:flutter/material.dart';

import 'package:hospital_database_app/components/my_button.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/cross_faded_wrapper.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/admission_row.dart';
import 'package:hospital_database_app/views/new/components/patient_row.dart';
import 'package:hospital_database_app/views/new/components/procedure_grid.dart';
import 'package:hospital_database_app/views/new/components/room_row.dart';
import 'package:provider/provider.dart';

class NewAdmissionScreen extends StatelessWidget {
  const NewAdmissionScreen({Key? key}) : super(key: key);

  static const id = '/new/admission';

  @override
  Widget build(BuildContext context) {
    final appBarProvider = context.read<AppBarProvider>();
    final provider = context.read<NewDetailsProvider>();

    provider.initClass();

    return GestureDetector(
      onTap: appBarProvider.unshowOptions,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ProvidedAppBar(),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Selector<NewDetailsProvider, bool>(
              selector: (ctx, provider) => provider.inAsync,
              builder: (ctx, inAsync, child) {
                return CrossFadedWrapper(
                  inAsync: inAsync,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 150),
                    child: FocusTraversalGroup(
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 70),
                          ),
                          const AdmissionRow(),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 70),
                          ),
                          const PatientRow(),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 70),
                          ),
                          const RoomRow(),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 70),
                          ),
                          const ProcedureGrid(),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 70),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 200),
                              alignment: Alignment.centerRight,
                              child: const MyButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 22,
                                ),
                                text: 'Add new admission',
                                color: kGrayColor,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 150),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const AppBarOptions()
          ],
        ),
      ),
    );
  }
}
