import 'package:flutter/material.dart';
import 'package:hospital_database_app/models/core/procedure_details.dart';

class NewAdmissionProvider with ChangeNotifier {
  final List<ProcedureDetails> procedures = [
    ProcedureDetails(),
  ];

  void addProcedure() {
    procedures.add(ProcedureDetails());
    notifyListeners();
  }

  void removeProcedure(int i) {
    procedures.removeAt(i);
    notifyListeners();
  }
}
