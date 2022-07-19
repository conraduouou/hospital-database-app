import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:intl/intl.dart';

class ProcedureDetails implements Details {
  ProcedureDetails({
    this.id,
    this.name,
    this.cost,
    this.lastDone,
    this.timesDone,
    this.labNumber,
    this.procedureDate,
    this.admissions,
  });

  String? id;
  String? name;
  double? cost;
  DateTime? lastDone;
  int? timesDone;

  String? labNumber;
  DateTime? procedureDate;

  List<AdmissionDetails>? admissions;

  String get costString => '${cost!.toStringAsFixed(0)} php';
  String get lastDoneFormatted =>
      lastDone == null ? 'N/A' : DateFormat.yMd().format(lastDone!);
  String get procedureDateFormatted => DateFormat.yMd().format(procedureDate!);

  Map<String, String> get procedure => {
        'Procedure ID': id!,
        'Name': name!,
        'Cost': costString,
        'Times done': timesDone == null ? '0' : timesDone.toString(),
      };

  @override
  List<String> getBodyData(TableType tableType) {
    if (tableType == TableType.admissions) {
      return [
        id!,
        name!,
        costString,
        labNumber!,
        procedureDateFormatted,
      ];
    } else if (tableType == TableType.procedures) {
      return [
        id!,
        name!,
        costString,
        lastDoneFormatted,
        timesDone.toString(),
      ];
    }

    throw 'Unexpected table type in ProcedureDetails class';
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
      admissionDetails.add(admission.patient!.name!);
      admissionDetails.add(admission.illness!);
      admissionDetails.add(admission.doctor!.name!);
      admissionDetails.add(admission.room!.number!.toString());

      toReturn.add(admissionDetails);
    }

    return toReturn;
  }
}
