import 'package:f1fantasy/models/driver_model.dart';

class LeagueDetails {
  String gpName;
  int year;
  int round;
  List<Driver> drivers;
  Driver fastest;
  bool fastestResult;
  Driver pole;
  bool poleResult;
  Driver userDriver;
  int userDriverPosition;
  bool userDriverResult;
  int points;
  LeagueDetails(
      {this.gpName,
      this.year,
      this.round,
      this.drivers,
      this.points,
      this.fastest,
      this.pole,
      this.userDriver,
      this.userDriverPosition});
  LeagueDetails.jsonToModel(Map<String, dynamic> json) {
    drivers = (json["drivers"] as List)
        .map((driver) => Driver.jsonToModel(driver))
        .toList();
    year = int.parse(json["year"]);
    round = int.parse(json["round"]);
    points = json["points"];
    gpName = json["gpName"];
    fastest = Driver.jsonToModel(json["fastest"]);
    pole = Driver.jsonToModel(json["pole"]);
    userDriver = Driver.jsonToModel(json["userDriver"]);
    userDriverPosition = json["userDriverPosition"];
    fastestResult = json["fastestResult"];
    poleResult = json["poleResult"];
    userDriverResult = json["userDriverResult"];
  }
}
