import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/details.dart';

class DoctorDetails implements Details {
  DoctorDetails({
    this.id,
    this.name,
    this.pcf,
    this.department,
    this.admissionCount,
    this.handlingCount,
    this.admissions,
  });

  String? id;
  String? name;
  int? pcf;
  String? department;
  int? admissionCount;
  int? handlingCount;

  List<AdmissionDetails>? admissions;

  bool get isExisting => id != null && id!.compareTo('New') != 0;

  Map<String, String> get doctor => {
        'Doctor ID': id!,
        'Name': name!,
        'PCF (Peso conversion factor)': pcf!.toString(),
        'Department': department!,
      };

  @override
  List<String> getBodyData(TableType tableType) {
    return [
      id!,
      name!,
      department!,
      admissionCount!.toString(),
      handlingCount!.toString(),
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

      admissionDetails.add(admission.id!);
      admissionDetails.add(admission.admissionDateFormatted);
      admissionDetails.add(admission.dateDischargedFormatted);
      admissionDetails.add(admission.patient!.name!);
      admissionDetails.add(admission.room!.number.toString());

      toReturn.add(admissionDetails);
    }

    return toReturn;
  }
}
