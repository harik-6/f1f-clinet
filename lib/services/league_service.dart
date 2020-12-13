import 'dart:convert' as convert;
import 'package:f1fantasy/models/driver_model.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/models/user_league_details.dart';
import 'package:f1fantasy/models/user_league_model.dart';
import 'package:f1fantasy/services/native/auth_service.dart';
import 'package:f1fantasy/services/native/pref_service.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/driver_credit_model.dart';

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
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 8));
  }

  get defaultCacheTime {
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 5));
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

  Future<bool> joinLeague(
      List<DriverCredit> drivers,
      String poleId,
      String fastestId,
      String customId,
      int customPosition,
      GrandPrix active) async {
    List<String> dids = drivers
        .where((dr) => dr.isSelected == true)
        .map((dr) => dr.driver.id)
        .toList();
    Map<String, dynamic> requestBody = {
      "gpName": active.gpName,
      "round": active.round,
      "year": DateTime.now().year,
      "leagueDriverIds": dids,
      "poleDriverId": poleId,
      "fastestDriverId": fastestId,
      "customDriverId": customId,
      "customDriverPosition": customPosition,
      "uid": AuthService().getUser().uid,
    };
    var response =
        await _restService.post(AppConstants.apijoinleague, requestBody);
    PrefService prefService = PrefService();
    if (response.statusCode == 201) {
      // if (true) {
      List<Driver> driversToCahce =
          drivers.where((dr) => dr.isSelected == true).map((dr) {
        dr.driver.points = 0;
        return dr.driver;
      }).toList();
      Map<String, Driver> drMap = Map<String, Driver>();
      drivers.forEach((dr) {
        drMap[dr.driver.id] = dr.driver;
      });
      Driver fastest = drMap[fastestId];
      Driver pole = drMap[poleId];
      Driver custom = drMap[customId];
      Map<String, dynamic> tocache = {
        "gpName": active.gpName,
        "round": active.round.toString(),
        "drivers": driversToCahce,
        "year": DateTime.now().year.toString(),
        "points": 0,
        "fastest": fastest,
        "pole": pole,
        "userDriver": custom,
        "userDriverPosition": customPosition,
        "userDriverResult": false,
        "fastestResult": false,
        "poleResult": false
      };
      await prefService.writData(
          AppConstants.cachejoinleague + active.round.toString(),
          convert.jsonEncode(tocache));
      return true;
    }
    return false;
  }

  Future<LeagueDetails> readSelection(GrandPrix activeleague) async {
    String cache = await PrefService()
        .readDate(AppConstants.cachejoinleague + activeleague.round.toString());
    if (cache == null) return null;
    return LeagueDetails.jsonToModel(convert.jsonDecode(cache));
  }

  Future<List<League>> getUserLeagues() async {
    var response = await _restService.get(AppConstants.cacheuserleagues,
        AppConstants.apiuserleagues, defaultStandingsCacheTime);
    if (response.statusCode == 204) {
      return [];
    }
    Map data = convert.jsonDecode(response.body);
    List<League> lgs = (data["leagues"] as List)
        .map((league) => League.jsonToModel(league))
        .toList();
    lgs.sort((a, b) => a.round > b.round ? 1 : -1);
    return lgs;
  }

  Future<LeagueDetails> getLeagueDetails(League league) async {
    String query =
        "?year=" + league.year.toString() + "&round=" + league.round.toString();
    var response = await _restService.get(
        AppConstants.cacheuserleaguesdetails + query,
        AppConstants.apiuserleaguesdetails + query,
        defaultStandingsCacheTime);
    if (response.statusCode == 204) {
      return null;
    }
    Map data = convert.jsonDecode(response.body);
    LeagueDetails lg = LeagueDetails.jsonToModel(data["leagueDetail"]);
    return lg;
  }
}
