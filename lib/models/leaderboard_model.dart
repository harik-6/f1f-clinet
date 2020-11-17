class Leaderboard {
  String name;
  int points;
  int leagueCount;
  Leaderboard({this.name, this.points, this.leagueCount});

  Leaderboard.jsonToModel(Map<String, dynamic> json) {
    name = json["name"];
    points = json["points"];
    leagueCount = json["leagueCount"];
  }
}
