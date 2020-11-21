import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/constructor_model.dart';
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/models/race_result_model.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'dart:convert' as convert;

class ResultService {
  get defaultResultCacheTime {
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 7));
  }

  get defaultStandingsCacheTime {
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 45));
  }

  Future<List<RaceResult>> getraceResults(int round) async {
    RestService service = RestService();
    String rnd = round.toString();
    String url = AppConstants.apiraceresults + rnd;
    var response = await service.get(
        AppConstants.cacheraceresults + rnd, url, defaultResultCacheTime);
    if (response.statusCode == 204) {
      return Future.value([]);
    }
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    List<RaceResult> results = (data["result"] as List)
        .map((obj) => RaceResult.jsonToModel(obj))
        .toList();
    results.sort((a, b) => a.position > b.position ? 1 : -1);
    return Future.value(results);
  }

  Future<List<Driver>> getDriverStandings() async {
    RestService service = RestService();
    var response = await service.get(AppConstants.cachedriverstandings,
        AppConstants.apidriverstandings, defaultStandingsCacheTime);
    if (response.statusCode == 204) {
      return Future.value([]);
    }
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    List<Driver> results = (data["standings"] as List)
        .map((obj) => Driver.jsonToModel(obj))
        .toList();
    results.sort((a, b) => a.points < b.points ? 1 : -1);
    return Future.value(results);
  }

  Future<List<Constructor>> getConstructorStandings() async {
    RestService service = RestService();
    var response = await service.get(AppConstants.apiconstructorstandings,
        AppConstants.apiconstructorstandings, defaultStandingsCacheTime);
    if (response.statusCode == 204) {
      return Future.value([]);
    }
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    List<Constructor> results = (data["standings"] as List)
        .map((obj) => Constructor.jsonToModel(obj))
        .toList();
    results.sort((a, b) => a.points < b.points ? 1 : -1);
    return Future.value(results);
  }
}
