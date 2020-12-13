import 'dart:convert' as convert;
import 'package:f1fantasy/models/grand_prix_model.dart';
import 'package:f1fantasy/services/native/rest_service.dart';
import 'package:f1fantasy/constants/app_constants.dart';

class GpService {
  static RestService _restService;
  static final GpService _instance = GpService._internal();
  factory GpService() {
    return _instance;
  }
  GpService._internal() {
    _restService = RestService();
  }

  get defaultCacheTime {
    DateTime now = DateTime.now().toLocal();
    return now.add(Duration(days: 5));
  }

  Future<List<GrandPrix>> getGrandPrixs() async {
    var response = await _restService.get(AppConstants.cacheraceschedule,
        AppConstants.apiraceschedule, defaultCacheTime);
    if (response.statusCode == 204) {
      return [];
    }
    Map data = convert.jsonDecode(response.body);
    List<GrandPrix> list = (data["granprixs"] as List)
        .map((obj) => GrandPrix.jsonToModel(obj))
        .toList();
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return list;
  }
}
