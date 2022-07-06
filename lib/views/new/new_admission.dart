import 'package:flutter/material.dart';

import 'package:hospital_database_app/components/add_dropdown.dart';
import 'package:hospital_database_app/components/custom_appbar.dart';
import 'package:hospital_database_app/components/custom_button.dart';
import 'package:hospital_database_app/components/gear_dropdown.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/new_admission_provider.dart';
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
    return Consumer<AppBarProvider>(
      builder: (ctx, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            provider.deselectAddItems();
            return true;
          },
          child: GestureDetector(
            onTap: provider.unshowOptions,
            child: ChangeNotifierProvider<NewAdmissionProvider>(
              create: (ctx) => NewAdmissionProvider(),
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CustomAppBar(
                  gearOnTap: () {
                    provider.shouldShowGearOptions =
                        !provider.shouldShowGearOptions;
                  },
                  addOnTap: () {
                    provider.shouldShowAddOptions =
                        !provider.shouldShowAddOptions;
                  },
                ),
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
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
                              child: const CustomButton(
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
                    AnimatedPositioned(
                      top: provider.shouldShowAddOptions ? 0 : -250,
                      right: 50,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      child: const AddDropdown(),
                    ),
                    AnimatedPositioned(
                      top: provider.shouldShowGearOptions ? 0 : -200,
                      right: 0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      child: const GearDropdown(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
