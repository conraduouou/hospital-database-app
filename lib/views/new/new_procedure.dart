import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_button.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/procedure_grid_block.dart';
import 'package:provider/provider.dart';

class NewProcedureScreen extends StatelessWidget {
  const NewProcedureScreen({Key? key}) : super(key: key);

  static const id = '/new/procedure';

  @override
  Widget build(BuildContext context) {
    final appBarProvider = context.read<AppBarProvider>();
    final provider = context.read<NewDetailsProvider>();
    return GestureDetector(
      onTap: appBarProvider.unshowOptions,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ProvidedAppBar(),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 150),
              child: FocusTraversalGroup(
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 70),
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 420,
                      ),
                      delegate: SliverChildListDelegate([
                        ProcedureGridBlock(
                          showFirst: true,
                          heading: 'New Procedure',
                          children: [
                            Selector<NewDetailsProvider, String?>(
                              selector: (c, p) => p.procedures[0].id,
                              builder: (ctx, id, child) {
                                return MyDropdownButton(
                                  showDropdown: false,
                                  text: id ?? '',
                                  color: kLightGrayColor,
                                  textColor: kDarkGrayColor,
                                  enabled: true,
                                  width: kTextFieldWidth,
                                );
                              },
                            ),
                            Selector<NewDetailsProvider, String?>(
                              selector: (c, p) => p.procedures[0].name,
                              builder: (ctx, name, child) {
                                return MyField(
                                  initialText: name,
                                  hintText: 'Name',
                                  width: kTextFieldWidth,
                                  onChanged: (s) {
                                    provider.onChanged(
                                      s,
                                      index: 0,
                                      attribute: Attribute.procedureName,
                                    );
                                  },
                                );
                              },
                            ),
                            Selector<NewDetailsProvider, double?>(
                              selector: (c, p) => p.procedures[0].cost,
                              builder: (ctx, cost, child) {
                                return MyField(
                                  initialText: cost?.toString(),
                                  isDigitsOnly: true,
                                  hintText: 'Cost',
                                  width: kTextFieldWidth,
                                  onChanged: (s) {
                                    provider.onChanged(
                                      s,
                                      index: 0,
                                      attribute: Attribute.procedureCost,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ]),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 70),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 200),
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
            const AppBarOptions(),
          ],
        ),
      ),
    );
  }
}
