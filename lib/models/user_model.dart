class AppUser {
  String uid;
  String name;
  String email;
  String photoUrl;
  // String favTeam;
  AppUser({this.uid, this.name, this.email, this.photoUrl});
  AppUser.jsonToModel(Map<String, dynamic> json) {
    uid = json["uid"];
    email = json["email"];
    name = json["name"];
    photoUrl = json["photoUrl"];
  }

  Map<String, dynamic> modeltoJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl};
}
