import 'package:flutter/material.dart';

class AppConstants {
  static String apiurl = "http://192.168.42.218:8080";
  static String apiraceresults =
      apiurl + "/results?year=" + getyear() + "&round=";
  static String apidriverstandings = apiurl + "/standings/drivers";
  static String apiconstructorstandings = apiurl + "/standings/constructors";
  static String apidrivercredits = apiurl + "/league/credits?year=2020&round=";
  static String apiraceschedule = apiurl + "/schedule";
  static String apijoinleague = apiurl + "/league/join";
  static String apiuserleagues = apiurl + "/league/user";
  static String apileaderboard = apiurl + "/leaderboard";
  static String apicachestatus =
      apiurl + "/racestatus?year=" + getyear() + "&round=";
  static String cacheraceschedule = "grandprix";
  static String cachedriverstandings = "driverStandings";
  static String cacheconstructorstandings = "constructorStandings";
  static String cacheraceresults = "result#";
  static String cacheuserleagues = "userLeagues";
  static String cachejoinleague = "league#";
  static String cacheleaderboard = "leaderboard";
  static String cachecachestatus = "racestatus";
  static String cachedrivercredits = "credits#";

  static String getyear() {
    return DateTime.now().year.toString();
  }

  static final Map<String, Color> teamColorsMap = {
    "mercedes": Colors.green[300],
    "red_bull": Colors.blue[900],
    "ferrari": Colors.red,
    "williams": Colors.white,
    "mclaren": Colors.orange[700],
    "aston": Colors.green[900],
    "racin_gpoint": Colors.pink,
    "alphatauri": Colors.blueAccent,
    "renault": Colors.yellow,
    "alpine": Colors.yellow,
    "alfa": Colors.purple,
    "haas": Colors.brown
  };

  static final Map<String, String> teamImages = {
    "mercedes": 'assets/images/icons/mercedes.png',
    "red_bull": 'assets/images/icons/redbull.png',
    "racing_point": 'assets/images/icons/racing_point.png',
    "aston": 'assets/images/icons/aston.png',
    "mclaren": 'assets/images/icons/mclaren.png',
    "renault": 'assets/images/icons/renault.png',
    "alpine": 'assets/images/icons/alpine.png',
    "ferrari": 'assets/images/icons/ferrari.png',
    "alphatauri": 'assets/images/icons/tauri.png',
    "alfa": 'assets/images/icons/romeo.png',
    "williams": 'assets/images/icons/williams.png',
    "haas": 'assets/images/icons/haas.png'
  };
}
