import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/details.dart';

class PatientDetails implements Details {
  PatientDetails({
    this.id,
    this.name,
    this.address,
    this.contactNumber,
    this.age,
    this.gender,
    this.contactPersonName,
    this.contactPersonRelation,
    this.contactPersonNumber,
    this.admissions,
  });

  // patient-specific details
  String? id;
  String? name;
  String? address;
  String? contactNumber;
  int? age;
  String? gender;

  // contact-specific details
  String? contactPersonName;
  String? contactPersonRelation;
  String? contactPersonNumber;

  List<AdmissionDetails>? admissions;

  // to be used for state, determining if this is editable in the new admission
  // screen or not.
  bool get isExisting => id != null && id?.compareTo('New') != 0;

  bool get isCompleteForNew =>
      name != null &&
      name!.isNotEmpty &&
      address != null &&
      address!.isNotEmpty &&
      contactNumber != null &&
      contactNumber!.isNotEmpty &&
      age != null &&
      gender != null &&
      gender!.isNotEmpty &&
      contactPersonName != null &&
      contactPersonName!.isNotEmpty &&
      contactPersonRelation != null &&
      contactPersonRelation!.isNotEmpty &&
      contactPersonNumber != null &&
      contactPersonNumber!.isNotEmpty;

  Map<String, String> get patient => <String, String>{
        'Patient ID': id!,
        'Name': name!,
        'Address': address!,
        'Contact number': contactNumber!,
        'Age': age!.toString(),
        'Gender': gender!
      };

  Map<String, String> get contactPerson => <String, String>{
        'Name': contactPersonName!,
        'Relation to patient': contactPersonRelation!,
        'Contact number': contactPersonNumber!,
      };

  @override
  List<String> getBodyData(TableType tableType) {
    if (tableType == TableType.rooms || tableType == TableType.patients) {
      return [
        id!,
        name!,
        age!.toString(),
        gender!,
        address!,
      ];
    }

    throw 'Unexpected table type supplied in PatientDetails class.';
  }

  @override
  List<List<String>> getExtraData() {
    // return none if ever procedures isn't properly supplied
    if (admissions == null) {
      return [];
    }

    final toReturn = <List<String>>[];

    for (final admission in admissions!) {
      final admissionDetails = <String>[];

      admissionDetails.add(admission.id!);
      admissionDetails.add(admission.admissionDateFormatted);
      admissionDetails.add(admission.illness!);
      admissionDetails.add(admission.doctor!.name!);
      admissionDetails.add(admission.room!.number.toString());

      toReturn.add(admissionDetails);
    }

    return toReturn;
  }
}
