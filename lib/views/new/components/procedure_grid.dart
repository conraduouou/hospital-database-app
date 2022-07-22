import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/procedure_grid_block.dart';
import 'package:provider/provider.dart';

class ProcedureGrid extends StatelessWidget {
  const ProcedureGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewDetailsProvider>();

    return Selector<NewDetailsProvider, int>(
      selector: (c, p) => p.procedures.length,
      builder: (ctx, length, child) {
        return Selector<NewDetailsProvider, bool>(
          selector: (c, p) => p.hasPressed,
          builder: (ctx, hasPressed, child) {
            return Selector<NewDetailsProvider, bool>(
              selector: (c, p) => p.proceduresAreComplete(),
              builder: (ctx, isComplete, child) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 350,
                  ),
                  delegate: SliverChildListDelegate([
                    ...(() {
                      final procedures = provider.procedures;
                      final list = <Widget>[];

                      for (int i = 0; i <= length; i++) {
                        list.add(
                          Selector<NewDetailsProvider, bool>(
                            selector: (c, p) =>
                                i != length ? p.isGettingProcedure(i) : false,
                            builder: (ctx, inAsync, child) {
                              return ProcedureGridBlock(
                                key: ValueKey(i),
                                inAsync: inAsync,
                                showError: i == 0 && !isComplete && hasPressed,
                                showFirst: !inAsync && i != procedures.length,
                                showClose: i != 0,
                                heading: 'Procedure ${i + 1}',
                                onClose: () {
                                  provider.removeProcedure(i);
                                },
                                addOnTap: provider.addProcedure,
                                children: [
                                  Selector<NewDetailsProvider, String?>(
                                    selector: (c, p) =>
                                        i == length ? null : p.procedures[i].id,
                                    builder: (ctx, id, child) {
                                      return MyDropdownButton(
                                        showDropdown: i != length,
                                        text: id ?? '',
                                        textColor: id?.compareTo('New') == 0
                                            ? kDarkGrayColor
                                            : Colors.black,
                                        width: kTextFieldWidth,
                                        itemsHeading: 'Procedure ID',
                                        items: i != length
                                            ? provider.procedureDropdowns[i]
                                            : [],
                                        overlayTap: (index) {
                                          provider.onSelectItem(
                                            index,
                                            dropdownType:
                                                DropdownType.procedure,
                                            procedureIndex: i,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Selector<NewDetailsProvider, String?>(
                                    key: UniqueKey(),
                                    selector: (c, p) => i == length
                                        ? null
                                        : p.procedures[i].name,
                                    builder: (ctx, name, child) {
                                      return MyField(
                                        enabled: i != length
                                            ? !provider.procedures[i].isExisting
                                            : false,
                                        initialText: name,
                                        hintText: 'Name',
                                        width: kTextFieldWidth,
                                        onChanged: (s) {
                                          provider.onChanged(
                                            s,
                                            index: i,
                                            attribute: Attribute.procedureName,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Selector<NewDetailsProvider, double?>(
                                    key: UniqueKey(),
                                    selector: (c, p) => i == length
                                        ? null
                                        : p.procedures[i].cost,
                                    builder: (ctx, cost, child) {
                                      return MyField(
                                        enabled: i != length
                                            ? !provider.procedures[i].isExisting
                                            : false,
                                        initialText: cost?.toInt().toString(),
                                        isDigitsOnly: true,
                                        hintText: 'Cost',
                                        width: kTextFieldWidth,
                                        onChanged: (s) {
                                          provider.onChanged(
                                            s,
                                            index: i,
                                            attribute: Attribute.procedureCost,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                      return list;
                    })()
                  ]),
                );
              },
            );
          },
        );
      },
    );
  }
}
