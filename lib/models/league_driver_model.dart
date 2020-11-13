import 'package:f1fantasy/models/driver_model.dart';

class LeagueDriver {
  Driver driver;
  double creditPoints;
  bool isSelected;
  LeagueDriver(this.driver,this.creditPoints,this.isSelected);
  LeagueDriver.jsonToModel(Map<String, dynamic> json) {
    driver = Driver.jsonToModel(json["driver"]);
    creditPoints = json["creditPoints"]+0.0;
    isSelected = false;
  }
}