import 'dart:convert' as convert;
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
}
