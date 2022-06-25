import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hospital_database_app/hospital_app.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isMacOS) {
    setWindowTitle('Hospital Database App');
    setWindowMinSize(const Size(1280, 720));
  }
  runApp(HospitalApp());
}
