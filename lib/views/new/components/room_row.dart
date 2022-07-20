import 'package:flutter/material.dart';
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

    return AddBlock(
      heading: isNew ? 'New Room' : 'Room',
      children: [
        Selector<NewDetailsProvider, int?>(
          selector: (c, p) => p.newRoomNumber,
          builder: (ctx, number, child) {
            return MyDropdownButton(
              text: number.toString(),
              textColor: kDarkGrayColor,
              showDropdown: !isNew,
              width: kTextFieldWidth,
            );
          },
        ),
        Selector<NewDetailsProvider, String?>(
          selector: (c, p) => p.room.type,
          builder: (ctx, type, child) {
            return MyField(
              initialText: type,
              hintText: 'Type',
              width: kTextFieldWidth,
              onChanged: (s) {
                provider.onChanged(s, attribute: Attribute.roomType);
              },
            );
          },
        ),
        Selector<NewDetailsProvider, double?>(
          selector: (c, p) => p.room.cost,
          builder: (ctx, cost, child) {
            return MyField(
              initialText: cost?.toString(),
              isDigitsOnly: true,
              hintText: 'Cost',
              width: kTextFieldWidth,
              onChanged: (s) {
                provider.onChanged(s, attribute: Attribute.roomCost);
              },
            );
          },
        ),
        Selector<NewDetailsProvider, int?>(
          selector: (c, p) => p.room.capacity,
          builder: (ctx, capacity, child) {
            return MyField(
              initialText: capacity?.toString(),
              isDigitsOnly: true,
              hintText: 'Capacity',
              width: kTextFieldWidth,
              onChanged: (s) {
                provider.onChanged(s, attribute: Attribute.roomCapacity);
              },
            );
          },
        ),
      ],
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
    return AddBlock(
      heading: isNew ? 'New Doctor' : 'Doctor',
      children: [
        Selector<NewDetailsProvider, String?>(
          selector: (c, p) => p.newDoctorId,
          builder: (ctx, id, child) {
            return MyDropdownButton(
              text: id ?? '',
              textColor: kDarkGrayColor,
              showDropdown: !isNew,
              width: kTextFieldWidth,
            );
          },
        ),
        Selector<NewDetailsProvider, String?>(
          selector: (c, p) => p.doctor.name,
          builder: (ctx, name, child) {
            return MyField(
              initialText: name,
              hintText: 'Name',
              width: kTextFieldWidth,
              onChanged: (s) {
                provider.onChanged(s, attribute: Attribute.doctorName);
              },
            );
          },
        ),
        Selector<NewDetailsProvider, int?>(
          selector: (c, p) => p.doctor.pcf,
          builder: (ctx, pcf, child) {
            return MyField(
              initialText: pcf?.toString(),
              isDigitsOnly: true,
              hintText: 'PCF (Peso conversion factor)',
              width: kTextFieldWidth,
              onChanged: (s) {
                provider.onChanged(s, attribute: Attribute.doctorPCF);
              },
            );
          },
        ),
        Selector<NewDetailsProvider, String?>(
          selector: (c, p) => p.doctor.department,
          builder: (ctx, department, child) {
            return MyField(
              initialText: department,
              hintText: 'Department',
              width: kTextFieldWidth,
              onChanged: (s) {
                provider.onChanged(s, attribute: Attribute.doctorDepartment);
              },
            );
          },
        ),
      ],
    );
  }
}
