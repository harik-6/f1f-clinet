import 'package:f1fantasy/models/driver_model.dart';

class League {
  String gpName;
  int year;
  int round;
  List<Driver> drivers;
  int points;
  League(this.gpName,this.year,this.round,this.drivers,this.points);
  League.jsonToModel(Map<String, dynamic> json) {
    drivers = (json["drivers"] as List).map((driver) =>  Driver.jsonToModel(driver)).toList();
    year = json["year"];
    round = json["round"];
    points = json["points"];
    gpName = json["gpName"];
  }
}
