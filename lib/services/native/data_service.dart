import 'package:f1fantasy/constants/app_constants.dart';
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/services/native/pref_service.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'dart:convert' as convert;

class DataService {
  static final DataService _instance = DataService._internal();
  static PrefService _prefService;
  static RestService _restService;

  factory DataService() {
    _prefService = PrefService();
    _restService = RestService();
    return _instance;
  }

  DataService._internal();

  Future<bool> updateCacheStatus(GrandPrix activeGp) async {
    int round = activeGp.round;
    DateTime now = DateTime.now().toLocal();
    DateTime raceEndTime = activeGp.dateTime.add(Duration(hours: 3)).toLocal();
    if (now.isAfter(raceEndTime)) {
      Map<String, dynamic> reqBody = {
        "year": activeGp.dateTime.year,
        "round": round
      };
      var response =
          await _restService.post(AppConstants.apicachestatus, reqBody);
      Map body = convert.jsonDecode(response.body);
      bool isRaceDataUpdated = (body["raceStatus"] as bool);
      if (isRaceDataUpdated) {
        await _prefService.removeKey([
          AppConstants.cacheraceschedule,
          AppConstants.cacheuserleagues,
          AppConstants.cachedriverstandings,
          AppConstants.cacheconstructorstandings,
          AppConstants.cacheleaderboard
        ]);
        return true;
      }
    }
    return false;
  }

  Future<void> clearCache() async {
    await _prefService.removeKey([AppConstants.cacheraceschedule]);
    return;
  }
}
