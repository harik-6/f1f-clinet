import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static final PrefService _instance = PrefService._internal();
  factory PrefService() {
    return _instance;
  }
  PrefService._internal();

  Future<String> readDate(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(key)) {
      return pref.getString(key);
    }
    return null;
  }

  Future<bool> writData(String key, dynamic value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
    return true;
  }

  Future<bool> clearDate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    return true;
  }

  Future<bool> removeKey(List<String> keys) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < keys.length; i++) {
      await pref.remove(keys[i]);
    }
    return true;
  }
}
