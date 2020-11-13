class Constructor {
  Constructor(this.id,this.shortName,this.name,this.points);
  String id;
  String shortName;
  String name;
  int points;
  Constructor.jsonToModel(Map<String,dynamic> json) {
    id = json["cid"];
    shortName = json["shortName"];
    name = json["name"];
    points = json["points"];
  }
}