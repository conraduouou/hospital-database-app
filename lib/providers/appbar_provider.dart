import 'package:flutter/material.dart';
import 'package:hospital_database_app/models/core/animated_menu_item.dart';
import 'package:hospital_database_app/views/new/new_admission.dart';
import 'package:hospital_database_app/views/new/new_patient.dart';

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

  final addScreens = <String>[
    NewAdmissionScreen.id,
    NewPatientScreen.id,
  ];

  bool _shouldShowGearOptions = false;
  bool _shouldShowAddOptions = false;
  bool _isHome = false;

  bool get shouldShowGearOptions => _shouldShowGearOptions;
  bool get shouldShowAddOptions => _shouldShowAddOptions;
  bool get isHome => _isHome;

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

  set isHome(bool value) {
    _isHome = value;
    notifyListeners();
  }

  // called when going back from new _ screen
  void deselectAddItems() {
    _isHome = true;
    for (final menuItem in addItems) {
      menuItem.isSelected = false;
    }

    notifyListeners();
  }

  void selectMenuItem(int index, {required MenuType menuType}) {
    unshowOptions();

    final listToUse = menuType == MenuType.add ? addItems : gearItems;

    // deselect active first
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
    if (_shouldShowAddOptions || _shouldShowGearOptions) {
      _shouldShowAddOptions = false;
      _shouldShowGearOptions = false;
      notifyListeners();
    }
  }
}
