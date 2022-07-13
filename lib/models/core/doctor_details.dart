import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/details.dart';

class DoctorDetails implements Details {
  DoctorDetails({
    this.id = 'DID-0031',
    this.name = 'Dr. Angel R. Sikat',
    this.pcf = 40,
    this.department = 'Pulmonology',
    this.admissionCount = 4,
    this.handlingCount = 3,
    this.admissions,
  }) {
    admissions = <AdmissionDetails>[
      AdmissionDetails(
        admissionId: 'AID-0012',
        admissionDate: DateTime(2022, 3, 14),
        dateDischarged: DateTime(2022, 4, 9),
        patientName: 'John Lloyd dela Cruz',
        roomNumber: 301,
      ),
    ];
  }

  String id;
  String name;
  int pcf;
  String department;
  int admissionCount;
  int handlingCount;

  List<AdmissionDetails>? admissions;

  Map<String, String> get doctor => {
        'Doctor ID': id,
        'Name': name,
        'PCF (Peso conversion factor)': pcf.toString(),
        'Department': department,
      };

  @override
  List<String> getBodyData(TableType tableType) {
    return [
      id,
      name,
      department,
      admissionCount.toString(),
      handlingCount.toString(),
    ];
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

      admissionDetails.add(admission.admissionId);
      admissionDetails.add(admission.admissionDateFormatted);
      admissionDetails.add(admission.dateDischargedFormatted);
      admissionDetails.add(admission.patientName);
      admissionDetails.add(admission.roomNumber.toString());

      toReturn.add(admissionDetails);
    }

    return toReturn;
  }
}
