import 'dart:convert' as convert;
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/models/user_league_model.dart';
import 'package:f1fantasy/screens/league/joinleague/status_enum.dart';
import 'package:f1fantasy/services/native/pref_service.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/driver_credit_model.dart';
import 'package:f1fantasy/models/leaderboard_model.dart';

class LeagueService {
  static RestService _restService;
  static final LeagueService _instance = LeagueService._internal();
  factory LeagueService() {
    return _instance;
  }
  LeagueService._internal() {
    _restService = RestService();
  }

  get defaultStandingsCacheTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 3);
  }

  Future<List<DriverCredit>> getDriverCredits(int round) async {
    try {
      var response = await _restService.get(
          api_driver_credits, api_driver_credits + round.toString());
      if (response.statusCode == 204) {
        return [];
      }
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      List<DriverCredit> results = (data["credits"]["driverCredits"] as List)
          .map((obj) => DriverCredit.jsonToModel(obj))
          .toList();
      results.sort((a, b) => a.creditPoints < b.creditPoints ? 1 : -1);
      return results;
    } catch (error) {
      print("Error in getting driver credits " + error.toString());
      return [];
    }
  }

  Future<List<GrandPrix>> getGrandPrixs() async {
    try {
      var response =
          await _restService.get(api_race_schedule, api_race_schedule);
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

  Future<STATUS> joinLeague(
      List<DriverCredit> drivers, GrandPrix active) async {
    List<String> dids = drivers
        .where((dr) => dr.isSelected == true)
        .map((dr) => dr.driver.id)
        .toList();
    Map<String, dynamic> requestBody = {
      "gpName": active.gpName,
      "round": active.round,
      "driverIds": dids,
      "uid": "userIdComesHere",
      "year": DateTime.now().year
    };
    var response = await _restService.post(api_join_league, requestBody);
    PrefService prefService = PrefService();
    if (response.statusCode == 201) {
      print("success joined the league");
      List<Driver> dataToCahce = drivers
          .where((dr) => dr.isSelected == true)
          .map((dr) => dr.driver)
          .toList();
      await prefService.writData(cache_join_league + active.round.toString(),
          convert.jsonEncode(dataToCahce));
      return STATUS.success;
    }
    if (response.statusCode == 200) {
      print("alread joined the league");
      var data = convert.jsonDecode(response.body);
      print("Status 200 already joined");
      print(data["league"].toString());
      await prefService.writData(cache_join_league + active.round.toString(),
          convert.jsonEncode(data["league"]["drivers"]));
      return STATUS.hasjoinedAlready;
    }
    return STATUS.failed;
  }

  Future<List<Driver>> readSelection(GrandPrix activeleague) async {
    String cache = await PrefService()
        .readDate(cache_join_league + activeleague.round.toString());
    if (cache == null) return [];
    return (convert.jsonDecode(cache) as List)
        .map((datum) => Driver.jsonToModel(datum))
        .toList();
  }

  Future<List<League>> getUserLeagues() async {
    try {
      var response = await _restService.get(
          cache_user_leagues, api_user_leagues, defaultStandingsCacheTime);
      if (response.statusCode == 204) {
        return [];
      }
      Map data = convert.jsonDecode(response.body);
      List<League> lgs = (data["leagues"] as List)
          .map((league) => League.jsonToModel(league))
          .toList();
      return lgs;
    } catch (error) {
      print("Error in getting user leagues " + error.toString());
      return [];
    }
  }

  Future<List<Leaderboard>> getLeaderboard() async {
    try {
      var response = await _restService.get(
          cache_leaderboard, api_leaderboard, defaultStandingsCacheTime);
      if (response.statusCode == 204) {
        return [];
      }
      Map data = convert.jsonDecode(response.body);
      List<Leaderboard> lgs = (data["leaderboard"] as List)
          .map((lb) => Leaderboard.jsonToModel(lb))
          .toList();
      lgs.sort((a, b) => a.points < b.points ? 1 : -1);
      return lgs;
    } catch (error) {
      print("Error in getting leaderboard " + error.toString());
      return [];
    }
  }
}
