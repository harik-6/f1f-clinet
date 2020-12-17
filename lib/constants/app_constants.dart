import 'package:flutter/material.dart';

class AppConstants {
  static final String serverUrl = "https://apif1f.xyz/apis21/";
  static final String apiurl = serverUrl;
  static final String apiraceresults = apiurl + "results";
  static final String apidriverstandings = apiurl + "standings/drivers";
  static final String apiconstructorstandings =
      apiurl + "standings/constructors";
  static final String apidrivercredits = apiurl + "league/credits";
  static final String apiraceschedule = apiurl + "schedule";
  static final String apijoinleague = apiurl + "league/join";
  static final String apiuserleagues = apiurl + "league/user";
  static final String apiuserleaguesdetails = apiurl + "league/details";
  static final String apileaderboard = apiurl + "leaderboard";
  static final String apileaguleaderboard = apiurl + "leaderboard/league";
  static final String apicachestatus = apiurl + "racestatus";
  static final String cacheraceschedule = "grandprix";
  static final String cachedriverstandings = "driverStandings";
  static final String cacheconstructorstandings = "constructorStandings";
  static final String cacheraceresults = "result#";
  static final String cacheuserleagues = "userLeagues";
  static final String cacheuserleaguesdetails = apiurl + "leaguedetails#";
  static final String cachejoinleague = "league#";
  static final String cacheleaderboard = "leaderboard";
  static final String cacheleagueleaderboard = "leaderboard#league";
  static final String cachedrivercredits = "credits#";
  static final String toReview = "toReview";
  static final String reviewed = "userReviewed";

  static final Map<String, Color> teamColorsMap = {
    "mercedes": Colors.green[300],
    "red_bull": Colors.blue[900],
    "ferrari": Colors.red,
    "williams": Colors.white,
    "mclaren": Colors.orange[700],
    "aston": Colors.green[900],
    "alphatauri": Colors.blueAccent,
    "alpine": Colors.yellow,
    "alfa": Colors.purple,
    "haas": Colors.brown
  };

  static final Map<String, String> teamImages = {
    "mercedes": 'assets/images/icons/mercedes.png',
    "red_bull": 'assets/images/icons/redbull.png',
    "aston": 'assets/images/icons/aston.png',
    "mclaren": 'assets/images/icons/mclaren.png',
    "alpine": 'assets/images/icons/alpine.png',
    "ferrari": 'assets/images/icons/ferrari.png',
    "alphatauri": 'assets/images/icons/tauri.png',
    "alfa": 'assets/images/icons/romeo.png',
    "williams": 'assets/images/icons/williams.png',
    "haas": 'assets/images/icons/haas.png'
  };
}
