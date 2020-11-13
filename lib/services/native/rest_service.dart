import 'package:f1fantasy/services/native/pref_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RestService {
  static final RestService _instance = RestService._internal();
  static PrefService _cacheService;

  factory RestService() {
    return _instance;
  }

  get defaultCacheTime{
    DateTime now = DateTime.now().toLocal();
    return DateTime(now.year,now.month,now.day,now.hour+5,now.minute);
  }

  RestService._internal() {
    _cacheService = PrefService();
  }

  Future<http.Response> get(String key, String url,
      [DateTime cacheTill]) async {
    if(cacheTill == null) {
      cacheTill = defaultCacheTime;
    }
    String cache = await _cacheService.readDate(key);
    if (cache != null) {
      print("data from the cahe " + url);
      Map json = convert.jsonDecode(cache);
      DateTime valid = DateTime.parse(json["validTill"]);
      if (valid.isAfter(DateTime.now())) {
        return http.Response(json["value"], 200);
      }
    }
    print("data from the api call " + url);
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String value = convert.jsonEncode({
          "validTill": cacheTill.toLocal().toString(),
          "value": response.body
        });
        await _cacheService.writData(key, value);
      }
      return response;
    } catch (error) {
      print("Error in calling " + url);
      print("Error message " + error.toString());
      throw Error();
    }
  }

  Future<http.Response> post(String url,Map<String,dynamic> reqBody) async {
    Map<String,String> headers = {
      "Content-Type" : "application/json"
    };
    return await http.post(url, body: convert.jsonEncode(reqBody),headers: headers );
  }
}
