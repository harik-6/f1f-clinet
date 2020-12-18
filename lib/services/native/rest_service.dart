import 'package:formulafantasy/services/native/auth_service.dart';
import 'package:formulafantasy/services/native/pref_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RestService {
  static final RestService _instance = RestService._internal();
  static PrefService _cacheService;
  static AuthService _authService;

  factory RestService() {
    return _instance;
  }

  RestService._internal() {
    _cacheService = PrefService();
    _authService = AuthService();
  }

  Future<http.Response> get(String key, String url, DateTime cacheTill) async {
    String cache = await _cacheService.readDate(key);
    if (cache != null) {
      Map json = convert.jsonDecode(cache);
      // print("data from cache " + url);
      DateTime valid = DateTime.parse(json["validTill"]);
      if (valid.isAfter(DateTime.now().toLocal())) {
        return http.Response(json["value"], 200);
      }
    }
    // print("data from backend " + url);
    Map<String, String> headers = {
      "Content-Type": "application/json;charset=utf-8",
      "x-client-identifier": _authService.getUser().uid
    };
    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String value = convert.jsonEncode({
          "validTill": cacheTill.toLocal().toString(),
          "value": response.body
        });
        await _cacheService.writData(key, value);
        return response;
      }
      return http.Response("", 204);
    } on Exception catch (_) {
      return http.Response("", 204);
    } catch (error) {
      return http.Response("", 204);
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> reqBody) async {
    Map<String, String> headers = {
      "Content-Type": "application/json;charset=utf-8",
      "x-client-identifier": _authService.getUser().uid
    };
    try {
      var response = await http.post(url,
          body: convert.jsonEncode(reqBody), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      }
      return http.Response("", 204);
    } on Exception catch (_) {
      return http.Response("", 204);
    } catch (error) {
      return http.Response("", 204);
    }
  }
}
