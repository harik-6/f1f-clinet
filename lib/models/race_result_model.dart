import 'package:f1fantasy/models/driver_model.dart';

class RaceResult {
  RaceResult(this.driver,this.position,this.time,this.points);
  Driver driver;
  int position;
  String time;
  int points;
  RaceResult.jsonToModel(Map<String,dynamic> json) {
    driver = Driver.jsonToModel(json["driver"]);
    position = json["position"];
    time = json["time"];
    points = json["points"];
  }
}
  