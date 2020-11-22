import 'package:f1fantasy/constants/app_enums.dart';

RACE_STATUS getStatus(dynamic status) {
  String st = status.toString();
  if (st == "COMPLETED") return RACE_STATUS.completed;
  if (st == "SCHEDULED") return RACE_STATUS.scheduled;
  if (st == "CANCELLED") return RACE_STATUS.cancelled;
  return RACE_STATUS.completed;
}

class GrandPrix {
  GrandPrix(this.gpName, this.circuitName, this.dateTime, this.round,
      this.raceStatus);
  String gpName;
  String circuitName;
  DateTime dateTime;
  DateTime qualyTime;
  int round;
  RACE_STATUS raceStatus;
  GrandPrix.jsonToModel(Map<String, dynamic> json) {
    gpName = json["gpName"];
    circuitName = json["circuitName"];
    dateTime = DateTime.parse(json["dateTime"]);
    qualyTime = DateTime.parse(json["qualyTime"]);
    round = json["round"];
    raceStatus = getStatus(json["status"]);
  }
}
