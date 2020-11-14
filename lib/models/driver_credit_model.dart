import 'package:f1fantasy/models/driver_model.dart';

class DriverCredit {
  Driver driver;
  double creditPoints;
  bool isSelected;
  DriverCredit(this.driver,this.creditPoints,this.isSelected);
  DriverCredit.jsonToModel(Map<String, dynamic> json) {
    driver = Driver.jsonToModel(json["driver"]);
    creditPoints = json["creditPoints"]+0.0;
    isSelected = false;
  }
}