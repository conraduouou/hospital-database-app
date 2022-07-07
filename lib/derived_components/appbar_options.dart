import 'package:flutter/material.dart';
import 'package:hospital_database_app/components/my_dropdown.dart';
import 'package:hospital_database_app/derived_components/add_dropdown_item.dart';
import 'package:hospital_database_app/derived_components/gear_dropdown_item.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class AppBarOptions extends StatelessWidget {
  const AppBarOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppBarProvider>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Selector<AppBarProvider, bool>(
          selector: (ctx, provider) => provider.shouldShowAddOptions,
          builder: (ctx, shouldShow, child) {
            return AnimatedPositioned(
              top: shouldShow ? 0 : -250,
              right: 50,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: MyDropdown(
                height: 220,
                shouldShowOptions: shouldShow,
                children: [
                  for (int i = 0; i < provider.addItems.length; i++)
                    AddDropdownItem(index: i),
                ],
              ),
            );
          },
        ),
        Selector<AppBarProvider, bool>(
          selector: (ctx, provider) => provider.shouldShowGearOptions,
          builder: (ctx, shouldShow, child) {
            return AnimatedPositioned(
              top: shouldShow ? 0 : -200,
              right: 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: MyDropdown(
                height: 90,
                shouldShowOptions: shouldShow,
                children: [
                  for (int i = 0; i < provider.gearItems.length; i++)
                    GearDropdownItem(index: i),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
