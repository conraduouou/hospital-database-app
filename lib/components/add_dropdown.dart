import 'package:flutter/material.dart';
import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/providers/appbar_provider.dart';
import 'package:hospital_database_app/views/new/new_admission.dart';
import 'package:provider/provider.dart';

class AddDropdown extends StatelessWidget {
  const AddDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('add built');
    return Consumer<AppBarProvider>(
      builder: (ctx, provider, child) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            height: 220,
            width: 240,
            color: kDarkPurpleColor,
            child: FocusTraversalGroup(
              descendantsAreFocusable: provider.shouldShowAddOptions,
              child: Column(
                children: [
                  for (int i = 0; i < provider.addItems.length; i++)
                    InkWell(
                      onHover: (isHovered) {
                        provider.hoverMenuItem(
                          i,
                          isHovered: isHovered,
                          menuType: MenuType.add,
                        );
                      },
                      onTap: () {
                        provider.selectMenuItem(
                          i,
                          menuType: MenuType.add,
                        );

                        Navigator.pushNamed(ctx, NewAdmissionScreen.id);
                      },
                      child: Container(
                        height: i == 0 || i == provider.addItems.length - 1
                            ? 50
                            : 40,
                        width: 240,
                        padding: i == 0
                            ? const EdgeInsets.only(top: 10)
                            : i == provider.addItems.length - 1
                                ? const EdgeInsets.only(bottom: 10)
                                : null,
                        color: provider.addItems[i].isHovered ||
                                provider.addItems[i].isSelected
                            ? kPurpleColor
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              provider.addItems[i].content,
                              style: kBoldStyle.copyWith(
                                color: Colors.white,
                                fontSize: kRegularSize,
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
