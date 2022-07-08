import 'package:flutter/material.dart';
import 'package:hospital_database_app/views/new/components/add_block.dart';
import 'package:hospital_database_app/components/my_dropdown_button.dart';
import 'package:hospital_database_app/components/my_field.dart';
import 'package:hospital_database_app/constants.dart';

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
    return AddBlock(
      heading: isNew ? 'New Room' : 'Room',
      children: [
        MyDropdownButton(
          text: '302 (new)',
          textColor: kDarkGrayColor,
          showDropdown: !isNew,
          width: kTextFieldWidth,
        ),
        const MyField(
          hintText: 'Type',
          width: kTextFieldWidth,
        ),
        const MyField(
          hintText: 'Cost',
          width: kTextFieldWidth,
        ),
        const MyField(
          hintText: 'Capacity',
          width: kTextFieldWidth,
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
    return AddBlock(
      heading: isNew ? 'New Doctor' : 'Doctor',
      children: [
        MyDropdownButton(
          text: 'DID-0032 (new)',
          textColor: kDarkGrayColor,
          showDropdown: !isNew,
          width: kTextFieldWidth,
        ),
        const MyField(
          hintText: 'Name',
          width: kTextFieldWidth,
        ),
        const MyField(
          hintText: 'PCF (Peso conversion factor)',
          width: kTextFieldWidth,
        ),
        const MyField(
          hintText: 'Department',
          width: kTextFieldWidth,
        ),
      ],
    );
  }
}
