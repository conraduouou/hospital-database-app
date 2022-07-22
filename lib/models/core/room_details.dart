import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';

class RoomDetails implements Details {
  RoomDetails({
    this.number,
    this.type,
    this.cost,
    this.capacity,
    this.occupantCount,
    this.patients,
  });

  // room-specific data
  int? number;
  String? type;
  double? cost;
  int? capacity;
  int? occupantCount;

  // for getExtraData
  List<PatientDetails>? patients;

  String get roomCostString => '${cost!.toStringAsFixed(0)} php';
  bool get isExisting => number != null;

  bool get isCompleteForNew =>
      type != null && type!.isNotEmpty && cost != null && capacity != null;

  Map<String, String> get room => {
        'Room number': number!.toString(),
        'Type': type!,
        'Cost': roomCostString,
        'Capacity': capacity!.toString(),
        // 'Occupants': occupantCount!.toString(),
      };

  @override
  List<String> getBodyData(TableType tableType) {
    return [
      number!.toString(),
      type!,
      roomCostString,
      capacity!.toString(),
      occupantCount!.toString(),
    ];
  }

  @override
  List<List<String>> getExtraData() {
    if (patients == null) {
      throw 'Patients aren\'t supplied correctly';
    }

    final toReturn = <List<String>>[];

    for (final patient in patients!) {
      final patientDetails = <String>[];

      patientDetails.add(patient.id!);
      patientDetails.add(patient.name!);
      patientDetails.add(patient.age!.toString());
      patientDetails.add(patient.gender!);
      patientDetails.add(patient.address!);

      toReturn.add(patientDetails);
    }

    return toReturn;
  }
}
