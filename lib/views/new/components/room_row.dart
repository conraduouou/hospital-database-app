import 'package:flutter/material.dart';
import 'package:hospital_database_app/derived_components/cross_faded_wrapper.dart';
import 'package:hospital_database_app/providers/new_details_provider.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:provider/provider.dart';

class RoomRow extends StatelessWidget {
  const RoomRow({
    Key? key,
    this.isNew = false,
  }) : super(key: key);

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 420,
      ),
      delegate: SliverChildListDelegate([
        const RoomBlock(),
        const DoctorBlock(),
      ]),
    );
  }
}

class RoomBlock extends StatelessWidget {
  const RoomBlock({
    Key? key,
    this.isNew = false,
  }) : super(key: key);

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewDetailsProvider>();

    return Selector<NewDetailsProvider, bool>(
      selector: (c, p) => p.isGettingRoom,
      builder: (ctx, inAsync, child) {
        return CrossFadedWrapper(
          inAsync: inAsync,
          alignment: Alignment.centerLeft,
          loadingWidget: const Padding(
            padding: EdgeInsets.only(left: 170),
            child: CircularProgressIndicator(
              color: kPurpleColor,
            ),
          ),
          child: Selector<NewDetailsProvider, bool>(
            selector: (c, p) => p.hasPressed,
            builder: (ctx, hasPressed, child) {
              return Selector<NewDetailsProvider, bool>(
                selector: (c, p) => p.room.isCompleteForNew,
                builder: (ctx, isComplete, child) {
                  return AddBlock(
                    showError: !isComplete && hasPressed,
                    heading: isNew ? 'New Room' : 'Room',
                    children: [
                      Selector<NewDetailsProvider, int?>(
                        selector: (c, p) => p.room.number,
                        builder: (ctx, number, child) {
                          return MyDropdownButton(
                            text: number?.toString() ?? 'New',
                            textColor:
                                number == null ? kDarkGrayColor : Colors.black,
                            showDropdown: !isNew,
                            width: kTextFieldWidth,
                            itemsHeading: 'Room number',
                            items: provider.roomNumbers,
                            overlayTap: (index) {
                              provider.onSelectItem(index,
                                  dropdownType: DropdownType.room);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.room.type,
                        builder: (ctx, type, child) {
                          return MyField(
                            enabled: !provider.room.isExisting,
                            initialText: type,
                            hintText: 'Type',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.roomType);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, double?>(
                        selector: (c, p) => p.room.cost,
                        builder: (ctx, cost, child) {
                          return MyField(
                            enabled: !provider.room.isExisting,
                            initialText: cost?.toString(),
                            isDigitsOnly: true,
                            hintText: 'Cost',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.roomCost);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, int?>(
                        selector: (c, p) => p.room.capacity,
                        builder: (ctx, capacity, child) {
                          return MyField(
                            enabled: !provider.room.isExisting,
                            initialText: capacity?.toString(),
                            isDigitsOnly: true,
                            hintText: 'Capacity',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.roomCapacity);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class DoctorBlock extends StatelessWidget {
  const DoctorBlock({
    Key? key,
    this.isNew = false,
  }) : super(key: key);

  final bool isNew;
  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewDetailsProvider>();

    return Selector<NewDetailsProvider, bool>(
      selector: (c, p) => p.hasPressed,
      builder: (ctx, hasPressed, child) {
        return Selector<NewDetailsProvider, bool>(
          selector: (c, p) => p.isGettingDoctor,
          builder: (ctx, inAsync, child) {
            return CrossFadedWrapper(
              inAsync: inAsync,
              alignment: Alignment.centerLeft,
              loadingWidget: const Padding(
                padding: EdgeInsets.only(left: 170),
                child: CircularProgressIndicator(
                  color: kPurpleColor,
                ),
              ),
              child: Selector<NewDetailsProvider, bool>(
                selector: (c, p) => p.doctor.isCompleteForNew,
                builder: (ctx, isComplete, child) {
                  return AddBlock(
                    showError: !isComplete && hasPressed,
                    heading: isNew ? 'New Doctor' : 'Doctor',
                    children: [
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.doctor.id,
                        builder: (ctx, id, child) {
                          return MyDropdownButton(
                            // will be null at buildtime, but probably won't matter since at
                            // scroll, it would be finished loading up resources...
                            text: id ?? '',
                            textColor: id?.compareTo('New') == 0
                                ? kDarkGrayColor
                                : Colors.black,
                            showDropdown: !isNew,
                            width: kTextFieldWidth,
                            itemsHeading: 'Doctor ID',
                            items: provider.doctorIds,
                            overlayTap: (index) {
                              provider.onSelectItem(index,
                                  dropdownType: DropdownType.doctor);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.doctor.name,
                        builder: (ctx, name, child) {
                          return MyField(
                            enabled: !provider.doctor.isExisting,
                            initialText: name,
                            hintText: 'Name',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.doctorName);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, int?>(
                        selector: (c, p) => p.doctor.pcf,
                        builder: (ctx, pcf, child) {
                          return MyField(
                            enabled: !provider.doctor.isExisting,
                            initialText: pcf?.toString(),
                            isDigitsOnly: true,
                            hintText: 'PCF (Peso conversion factor)',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.doctorPCF);
                            },
                          );
                        },
                      ),
                      Selector<NewDetailsProvider, String?>(
                        selector: (c, p) => p.doctor.department,
                        builder: (ctx, department, child) {
                          return MyField(
                            enabled: !provider.doctor.isExisting,
                            initialText: department,
                            hintText: 'Department',
                            width: kTextFieldWidth,
                            onChanged: (s) {
                              provider.onChanged(s,
                                  attribute: Attribute.doctorDepartment);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
