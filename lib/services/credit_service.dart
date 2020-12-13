import 'dart:convert' as convert;
import 'package:f1fantasy/services/native/rest_service.dart';
import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/driver_credit_model.dart';

class CreditService {
  static RestService _restService;
  static final CreditService _instance = CreditService._internal();
  factory CreditService() {
    return _instance;
  }
  CreditService._internal() {
    _restService = RestService();
  }

  get defaultCacheTime {
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 3));
  }

  Future<List<DriverCredit>> getDriverCredits(int round, int year) async {
    String query = "?year=" + year.toString() + "&round=" + round.toString();
    var response = await _restService.get(
        AppConstants.cachedrivercredits + query,
        AppConstants.apidrivercredits + query,
        defaultCacheTime);
    if (response.statusCode == 204) {
      return [];
    }
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    List<DriverCredit> results = (data["credits"]["driverCredits"] as List)
        .map((obj) => DriverCredit.jsonToModel(obj))
        .toList();
    results.sort((a, b) => a.creditPoints < b.creditPoints ? 1 : -1);
    return results;
  }
}
