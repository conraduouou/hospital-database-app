import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/details.dart';

class PatientDetails implements Details {
  PatientDetails({
    this.id = 'PID-0031',
    this.name = 'John Lloyd dela Cruz',
    this.address = '55 Street, Mexico, Pampanga',
    this.contactNumber = '0935 784 3963',
    this.age = 27,
    this.gender = 'M',
    this.contactPersonName = 'Ana dela Cruz',
    this.contactPersonRelation = 'Mother',
    this.contactPersonNumber = '0912 345 2341',
  });

  // patient-specific details
  String id;
  String name;
  String address;
  String contactNumber;
  int age;
  String gender;

  // contact-specific details
  String contactPersonName;
  String contactPersonRelation;
  String contactPersonNumber;

  List<AdmissionDetails>? admissions;

  Map<String, String> get patient => <String, String>{
        'Patient ID': id,
        'Name': name,
        'Address': address,
        'Contact number': contactNumber,
        'Age': age.toString(),
        'Gender': gender
      };

  Map<String, String> get contactPerson => <String, String>{
        'Name': contactPersonName,
        'Relation to patient': contactPersonRelation,
        'Contact number': contactPersonNumber,
      };

  @override
  List<String> getBodyData(TableType tableType) {
    if (tableType == TableType.rooms || tableType == TableType.patients) {
      return [
        id,
        name,
        age.toString(),
        gender,
        address,
      ];
    }

    throw 'Unexpected table type supplied in PatientDetails class.';
  }

  @override
  List<List<String>> getExtraData() {
    // delete when real data is available
    admissions = <AdmissionDetails>[
      AdmissionDetails(
        admissionId: 'AID-0012',
        admissionDate: DateTime(2022, 3, 14),
        illness: 'Tuberculosis',
        doctorName: 'Dr. Angel R. Sikat',
        roomNumber: 301,
      ),
    ];

    // return none if ever procedures isn't properly supplied
    if (admissions == null) {
      return [];
    }

    final toReturn = <List<String>>[];

    for (final admission in admissions!) {
      final admissionDetails = <String>[];

      admissionDetails.add(admission.admissionId);
      admissionDetails.add(admission.admissionDateFormatted);
      admissionDetails.add(admission.illness);
      admissionDetails.add(admission.doctorName);
      admissionDetails.add(admission.roomNumber.toString());

      toReturn.add(admissionDetails);
    }

    return toReturn;
  }
}
