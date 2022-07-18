import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';

class SQLApi {
  SQLApi() {
    settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'root',
      password: 'iloveGod',
      db: 'hospital_database',
    );

    streamController = StreamController<bool>();

    // connect on initialize
    connect();
  }

  // to relay events, specifically for when the connection has been established
  late final StreamController<bool> streamController;

  late final ConnectionSettings settings;
  late final MySqlConnection connection;

  void connect() async {
    // simulate loading event--if true, then the state must be in async
    streamController.sink.add(true);

    connection = await MySqlConnection.connect(settings);

    streamController.sink.add(false);

    if (kDebugMode) print('finished connection');
  }

  // get admission records formatted for the home screen
  Future<Results> getAdmissionsForHome() async {
    const query =
        'select admission_id, date_format(admission_date, \'%m/%d/%Y\') as admission_date, patient_name, patient_illness, doctor_name, room_number '
        'from admissions as A, patients as P, doctors as D '
        'where A.doctor_id = D.doctor_id AND A.patient_id = P.patient_id '
        'order by 1';
    final results = await connection.query(query);

    return results;
  }

  Future<Results> getPatientsForHome() async {
    const query =
        'select patient_id, patient_name, patient_age, patient_gender, patient_address from patients';
    final results = await connection.query(query);

    return results;
  }

  Future<Results> getRoomsForHome() async {
    const sql = 'select R.room_number, room_type, room_cost, room_capacity, ( '
        'select count(*) from admissions as A where A.room_number = R.room_number and date_discharged is null '
        ') as occupants '
        'from rooms as R';
    final results = await connection.query(sql);

    return results;
  }

  Future<Results> getDoctorsForHome() async {
    const sql = 'select doctor_id, doctor_name, doctor_department, ( '
        'select count(*) from admissions as A where A.doctor_id = D.doctor_id and date_discharged is null '
        ') as currently_handling, ( '
        'select count(*) from admissions as A where A.doctor_id = D.doctor_id and date_discharged is not null '
        ') as worked_on '
        'from doctors as D';
    final results = await connection.query(sql);

    return results;
  }

  Future<Results> getProceduresForHome() async {
    const sql = 'select procedure_id, procedure_name, procedure_cost, ( '
        'select procedure_date from procedure_done where procedure_id = P.procedure_id order by 1 desc limit 1 '
        ') as last_done, ( '
        'select count(*) from procedure_done where procedure_id = P.procedure_id '
        ') as times_done '
        'from procedures as P';
    final results = await connection.query(sql);

    return results;
  }
}
