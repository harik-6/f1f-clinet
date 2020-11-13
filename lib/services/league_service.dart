import 'dart:convert' as convert;
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/league_driver_model.dart';

class LeagueService {
  static RestService _restService;
  static final LeagueService _instance = LeagueService._internal();
  factory LeagueService() {
    return _instance;
  }
  LeagueService._internal() {
    _restService = RestService();
  }

  Future<List<LeagueDriver>> getDriverCredits(int round) async {
    try {
      var response = await _restService.get(
          "drsCredits", api_driver_credits + round.toString());
      if (response.statusCode == 204) {
        return [];
      }
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      List<LeagueDriver> results = (data["credits"]["driverCredits"] as List)
          .map((obj) => LeagueDriver.jsonToModel(obj))
          .toList();
      results.sort((a, b) => a.creditPoints < b.creditPoints ? 1 : -1);
      return results;
    } catch (error) {
      return [];
    }
  }

  Future<List<GrandPrix>> getGrandPrixs() async {
    try {
      var response = await _restService.get("grandPrix", api_race_schedule);
      if (response.statusCode == 204) {
        return [];
      }
      Map data = convert.jsonDecode(response.body);
      List<GrandPrix> list = (data["granprixs"] as List)
          .map((obj) => GrandPrix.jsonToModel(obj))
          .toList();
      list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      return list;
    } catch (error) {
      return [];
    }
  }

  Future<void> joinLeague(List<LeagueDriver> drivers,GrandPrix active) {
    Map requestBody = {
      "gpName" : active.gpName,
      "round" : active.round,
      "driverSelection" : drivers,
      "uid" : "userIdComesHere"
    };
    print(requestBody.toString());
    Future.delayed(Duration(seconds:5));
    return null;
  }
}
