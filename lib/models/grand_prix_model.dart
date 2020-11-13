class GrandPrix {
  GrandPrix(
      this.gpName, this.circuitName, this.dateTime, this.round, this.active);
  String gpName;
  String circuitName;
  DateTime dateTime;
  int round;
  bool active;
  GrandPrix.jsonToModel(Map<String, dynamic> json) {
    gpName = json["gpName"];
    circuitName = json["circuitName"];
    dateTime = DateTime.parse(json["dateTime"]);
    round = json["round"];
    active = json["active"];
  }
}
