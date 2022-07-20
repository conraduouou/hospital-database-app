import 'package:flutter/material.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/procedure_grid_block.dart';
import 'package:provider/provider.dart';

class ProcedureGrid extends StatelessWidget {
  const ProcedureGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 350,
      ),
      delegate: SliverChildListDelegate([
        ...(() {
          final provider = context.read<NewDetailsProvider>();
          final length = context.select<NewDetailsProvider, int>(
            (provider) => provider.procedures.length,
          );
          final procedures = provider.procedures;
          final list = <Widget>[];

          for (int i = 0; i <= length; i++) {
            list.add(
              ProcedureGridBlock(
                index: i,
                showFirst: i != procedures.length,
                showClose: i != 0,
                heading: 'Procedure ${i + 1}',
                id: i < procedures.length
                    ? procedures[i].id ?? '0011 (new)'
                    : '',
                name: i < procedures.length ? procedures[i].name : null,
                cost: i < procedures.length
                    ? procedures[i].cost?.toString()
                    : null,
                onClose: () {
                  provider.removeProcedure(i);
                },
                addOnTap: () {
                  provider.addProcedure();
                },
              ),
            );
          }
          return list;
        })()
      ]),
    );
  }
}
