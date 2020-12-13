import 'dart:convert' as convert;
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/models/league_leaderboard_model.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/leaderboard_model.dart';

class LeaderboardService {
  static RestService _restService;
  static final LeaderboardService _instance = LeaderboardService._internal();
  factory LeaderboardService() {
    return _instance;
  }
  LeaderboardService._internal() {
    _restService = RestService();
  }

  get defaultStandingsCacheTime {
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 8));
  }

  get defaultLLCacheTime {
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 45));
  }

  Future<Map> getLeaderboard() async {
    var response = await _restService.get(AppConstants.cacheleaderboard,
        AppConstants.apileaderboard, defaultStandingsCacheTime);
    if (response.statusCode == 204) {
      return {};
    }
    Map data = convert.jsonDecode(response.body);
    Map leaderboardMap = {};
    List<Leaderboard> lgs = (data["leaderboard"] as List)
        .map((lb) => Leaderboard.jsonToModel(lb))
        .toList();
    lgs.sort((a, b) => a.points < b.points ? 1 : -1);
    leaderboardMap["leaderboard"] = lgs;
    Leaderboard mypos = Leaderboard.jsonToModel(data["myPosition"]);
    leaderboardMap["myPosition"] = mypos;
    return leaderboardMap;
  }

  Future<List<LLBoard>> getLeagueLeaderboard(GrandPrix league) async {
    String query =
        "?year=" + league.year.toString() + "&round=" + league.round.toString();
    String url = AppConstants.apileaguleaderboard + query;
    var response = await _restService.get(
        AppConstants.cacheleaderboard + query, url, defaultLLCacheTime);
    if (response.statusCode == 204) {
      return [];
    }
    Map data = convert.jsonDecode(response.body);
    List<LLBoard> lgs = (data["leaderboard"] as List)
        .map((lb) => LLBoard.jsonToModel(lb))
        .toList();
    lgs.sort((a, b) => a.points < b.points ? 1 : -1);
    return lgs;
  }
}