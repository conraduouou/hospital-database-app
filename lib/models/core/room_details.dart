import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:hospital_database_app/models/core/patient_details.dart';

class RoomDetails implements Details {
  RoomDetails({
    this.roomNumber = 301,
    this.roomType = 'Intensive Care Unit (ICU)',
    this.roomCost = 3500.0,
    this.roomCapacity = 4,
    this.occupantCount = 1,
    this.patients,
  });

  // room-specific data
  int roomNumber;
  String roomType;
  double roomCost;
  int roomCapacity;
  int occupantCount;

  // for getExtraData
  List<PatientDetails>? patients;

  String get roomCostString => '${roomCost.toStringAsFixed(0)} php';

  Map<String, String> get room => {
        'Room number': roomNumber.toString(),
        'Type': roomType,
        'Cost': roomCostString,
        'Capacity': roomCapacity.toString(),
        'Occupants': occupantCount.toString(),
      };

  @override
  List<String> getBodyData(TableType tableType) {
    return [
      roomNumber.toString(),
      roomType,
      roomCostString,
      roomCapacity.toString(),
      occupantCount.toString(),
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

      patientDetails.add(patient.id);
      patientDetails.add(patient.name);
      patientDetails.add(patient.age.toString());
      patientDetails.add(patient.gender);
      patientDetails.add(patient.address);

      toReturn.add(patientDetails);
    }

    return toReturn;
  }
}
