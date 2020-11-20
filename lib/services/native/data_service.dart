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

      if (now.isAfter(raceEndTime)) {
        var response = await _restService.get(AppConstants.cachecachestatus,
            AppConstants.apicachestatus + round.toString(), timeToCahe);
        Map body = convert.jsonDecode(response.body);
        bool isRaceDataUpdated = (body["status"] as bool);
        List<String> cacheToRemove = [
          AppConstants.cacheraceschedule,
          AppConstants.cacheuserleagues,
          AppConstants.cachedriverstandings,
          AppConstants.cacheconstructorstandings,
          AppConstants.cacheleaderboard
        ];
        if (isRaceDataUpdated) {
          _prefService.removeKey(cacheToRemove);
        }
      }
    } else {
      _prefService.clearDate();
    }
    return;
  }
}
