class Driver {
  Driver(this.id, this.firstName, this.secondName, this.team, this.points);
  String id;
  String firstName;
  String secondName;
  String team;
  int points;
  Driver.jsonToModel(Map<String, dynamic> json) {
    id = json["did"];
    firstName = json["firstName"];
    secondName = json["secondName"];
    team = json["team"];
    points = json["points"];
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "secondName": secondName,
      "team": team,
      "points": points
    };
  }
}
