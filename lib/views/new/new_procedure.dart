import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_button.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/derived_components/appbar_options.dart';
import 'package:hospital_database_app/derived_components/provided_appbar.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/views/new/components/procedure_grid_block.dart';
import 'package:provider/provider.dart';

class NewProcedureScreen extends StatelessWidget {
  const NewProcedureScreen({Key? key}) : super(key: key);

  static const id = '/new/procedure';

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppBarProvider>();
    return GestureDetector(
      onTap: provider.unshowOptions,
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
                        const ProcedureGridBlock(
                          isNew: true,
                          showFirst: true,
                          heading: 'New Procedure',
                          id: '0011 (new)',
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
