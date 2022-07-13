import 'package:hospital_database_app/constants.dart';
import 'package:hospital_database_app/models/core/admission_details.dart';
import 'package:hospital_database_app/models/core/details.dart';
import 'package:intl/intl.dart';

class ProcedureDetails implements Details {
  ProcedureDetails({
    this.tableType = TableType.procedures,
    this.id,
    this.name,
    this.cost,
    this.lastDone,
    this.timesDone,
    this.labNumber,
    this.procedureDate,
  });

  @override
  TableType tableType;

  String? id;
  String? name;
  double? cost;
  DateTime? lastDone;
  int? timesDone;

  String? labNumber;
  DateTime? procedureDate;

  List<AdmissionDetails>? admissions;

  String get costString => '${cost!.toStringAsFixed(0)} php';
  String get lastDoneFormatted => DateFormat.yMd().format(lastDone!);
  String get procedureDateFormatted => DateFormat.yMd().format(procedureDate!);

  @override
  List<String> get bodyData {
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
  List<List<String>> get extraData {
    // return none if ever procedures isn't properly supplied
    if (admissions == null) {
      return [];
    }

    final toReturn = <List<String>>[];

    for (final admission in admissions!) {
      final admissionDetails = <String>[];

      admissionDetails.add(admission.admissionId);
      admissionDetails.add(admission.admissionDateFormatted);
      admissionDetails.add(admission.patientName);
      admissionDetails.add(admission.illness);
      admissionDetails.add(admission.doctorName);
      admissionDetails.add(admission.roomNumber.toString());

      toReturn.add(admissionDetails);
    }

    return toReturn;
  }
}
