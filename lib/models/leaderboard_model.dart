class Leaderboard {
  String name;
  int points;
  int leagueCount;
  int position;
  int prevPoints;
  int prevPosition;
  Leaderboard(
      {this.name,
      this.points,
      this.leagueCount,
      this.position,
      this.prevPoints,
      this.prevPosition});

  Leaderboard.jsonToModel(Map<String, dynamic> json) {
    name = json["name"];
    points = json["points"];
    leagueCount = json["leagueCount"];
    position = json["position"];
    prevPoints = json["prevPoints"];
    prevPosition = json["prevPosition"];
  }
}
