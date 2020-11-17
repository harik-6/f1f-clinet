import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/constructor_model.dart';
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/models/race_result_model.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'dart:convert' as convert;

class ResultService {
  get defaultResultCacheTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 3);
  }

  get defaultStandingsCacheTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 3);
  }

  Future<List<RaceResult>> getraceResults(int round) async {
    try {
      RestService service = RestService();
      String rnd = (round - 4).toString();
      String url = api_race_results + rnd;
      var response = await service.get(
          cache_race_results + rnd, url, defaultResultCacheTime);
      if (response.statusCode == 204) {
        return Future.value([]);
      }
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      List<RaceResult> results = (data["result"] as List)
          .map((obj) => RaceResult.jsonToModel(obj))
          .toList();
      results.sort((a, b) => a.position > b.position ? 1 : -1);
      return Future.value(results);
    } catch (error) {
      print("Error in calling race result " + error.toString());
      return Future.value([]);
    }
  }

  Future<List<Driver>> getDriverStandings() async {
    try {
      RestService service = RestService();
      var response = await service.get(cache_driver_standings,
          api_driver_standings, defaultStandingsCacheTime);
      if (response.statusCode == 204) {
        return Future.value([]);
      }
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      List<Driver> results = (data["standings"] as List)
          .map((obj) => Driver.jsonToModel(obj))
          .toList();
      results.sort((a, b) => a.points < b.points ? 1 : -1);
      return Future.value(results);
    } catch (error) {
      print("Error in driver standings " + error.toString());
      return Future.value([]);
    }
  }

  Future<List<Constructor>> getConstructorStandings() async {
    try {
      RestService service = RestService();
      var response = await service.get(api_constructor_standings,
          api_constructor_standings, defaultStandingsCacheTime);
      if (response.statusCode == 204) {
        return Future.value([]);
      }
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      List<Constructor> results = (data["standings"] as List)
          .map((obj) => Constructor.jsonToModel(obj))
          .toList();
      results.sort((a, b) => a.points < b.points ? 1 : -1);
      return Future.value(results);
    } catch (error) {
      print("Error in constructor standings " + error.toString());
      return Future.value([]);
    }
  }
}
