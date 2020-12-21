class LLBoard {
  String name;
  int points;
  LLBoard({this.name, this.points});

  LLBoard.jsonToModel(Map<String, dynamic> json) {
    name = json["name"];
    points = json["points"];
  }
}
