class League {
  String gpName;
  int year;
  int round;
  int points;
  League(this.gpName, this.year, this.round, this.points);
  League.jsonToModel(Map<String, dynamic> json) {
    year = json["year"];
    round = json["round"];
    points = json["points"];
    gpName = json["gpName"];
  }
}
