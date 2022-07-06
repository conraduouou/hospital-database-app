import 'package:flutter/material.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';

enum MenuType {
  add,
  gear,
}

class AppBarProvider with ChangeNotifier {
  final addItems = <AnimatedMenuItem>[
    AnimatedMenuItem(content: 'New admission'),
    AnimatedMenuItem(content: 'New patient'),
    AnimatedMenuItem(content: 'New room'),
    AnimatedMenuItem(content: 'New doctor'),
    AnimatedMenuItem(content: 'New procedure'),
  ];
  final gearItems = <AnimatedMenuItem>[
    AnimatedMenuItem(content: 'Change password'),
    AnimatedMenuItem(content: 'Sign out'),
  ];

  bool _shouldShowGearOptions = false;
  bool _shouldShowAddOptions = false;

  bool get shouldShowGearOptions => _shouldShowGearOptions;
  bool get shouldShowAddOptions => _shouldShowAddOptions;

  set shouldShowGearOptions(bool value) {
    _shouldShowAddOptions = false;
    _shouldShowGearOptions = value;
    notifyListeners();
  }

  set shouldShowAddOptions(bool value) {
    _shouldShowGearOptions = false;
    _shouldShowAddOptions = value;
    notifyListeners();
  }

  void deselectAddItems() {
    for (final menuItem in addItems) {
      menuItem.isSelected = false;
    }

    notifyListeners();
  }

  void selectMenuItem(int index, {required MenuType menuType}) {
    unshowOptions();

    final listToUse = menuType == MenuType.add ? addItems : gearItems;

    for (final menuItem in listToUse) {
      if (menuItem.isSelected) {
        menuItem.toggleSelected();
        break;
      }
    }

    listToUse[index].toggleSelected();
    notifyListeners();
  }

  void hoverMenuItem(int index, {bool? isHovered, required MenuType menuType}) {
    final listToUse = menuType == MenuType.add ? addItems : gearItems;

    for (final menuItem in listToUse) {
      if (menuItem.isHovered) {
        menuItem.toggleHovered();
        break;
      }
    }

    listToUse[index].isHovered = isHovered ?? !listToUse[index].isHovered;
    notifyListeners();
  }

  void unshowOptions() {
    _shouldShowAddOptions = false;
    _shouldShowGearOptions = false;
    notifyListeners();
  }
}
