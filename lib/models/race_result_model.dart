import 'package:f1fantasy/models/driver_model.dart';

class RaceResult {
  RaceResult(this.driver,this.position,this.time,this.points,this.team);
  Driver driver;
  int position;
  String time;
  int points;
  String team;
  RaceResult.jsonToModel(Map<String,dynamic> json) {
    driver = Driver.jsonToModel(json["driver"]);
    position = json["position"];
    time = json["time"];
    points = json["points"];
    team = json["team"];
  }
}
  