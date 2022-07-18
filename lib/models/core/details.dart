import 'package:hospital_database_app/constants.dart';

/// Made to be implemented by any _`Details` class.
abstract class Details {
  /// This is only supplied whenever the implementation of this class is
  /// not of the same type as the supplied `tableType` parameter.
  ///
  /// This method that returns a `List` of `List`s usually contain the data of
  /// other implementations of this class. For example, the `AdmissionDetailsScreen`
  /// shows all the procedures done during that single admission; therefore, calling
  /// `AdmissionDetails.getExtraData()` would return a `List` of `String`s,
  /// each containing needed data for a single record.
  List<List<String>> getExtraData();

  /// This returns the data with respect to the supplied `TableType`, that is,
  /// depending on the screen.
  ///
  /// This is made so that there's no extra measure to take in making numerous
  /// nigh-identical implementations of the class dealing with the same data but
  /// on different screens (so that we wouldn't have to create
  /// `AdmissionDetailsOnHome` or 'AdmissionDetailsOnProcedureDetails`).
  ///
  /// That said, different data is then returned depending on the `tableType`
  /// supplied.
  ///
  /// The `AdmissionDetails` class would be the one most likely to use this the
  /// most, since it has different variations of data to view in various
  /// screens.
  List<String> getBodyData(TableType tableType);
}
