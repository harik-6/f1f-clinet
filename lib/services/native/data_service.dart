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

  Future<void> updateCacheStatus(GrandPrix activeGp, bool isseasonended) async {
    if (!isseasonended) {
      int round = activeGp.round;
      DateTime now = DateTime.now().toLocal();
      DateTime raceEndTime = activeGp.dateTime.add(Duration(hours: 3));
      DateTime timeToCahe = now.add(Duration(seconds: 15));
      print("Now " + now.toString());
      print("Racend time " + raceEndTime.toString());
      if (now.isAfter(raceEndTime)) {
        print("Race time completed");
        var response = await _restService.get(AppConstants.cachecachestatus,
            AppConstants.apicachestatus + round.toString(), timeToCahe);
        Map body = convert.jsonDecode(response.body);
        bool isRaceDataUpdated = (body["status"] as bool);
        print("current race update status " + isRaceDataUpdated.toString());
        if (isRaceDataUpdated) {
          print("race data is updated/pulling all the new data" +
              isRaceDataUpdated.toString());
          await forceUpdateCache();
          _prefService.writData("latestCacheUpdate", now.toString());
        }
      }
    } else {
      _prefService.clearDate();
    }
    return;
  }

  Future<void> forceUpdateCache() async {
    await _prefService.removeKey([
      AppConstants.cacheraceschedule,
      AppConstants.cacheuserleagues,
      AppConstants.cachedriverstandings,
      AppConstants.cacheconstructorstandings,
      AppConstants.cacheleaderboard
    ]);
  }
}
