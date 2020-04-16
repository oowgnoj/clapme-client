class User {
  String username;
  String email;
  String password;
  String profile;
  String profilePic;

  User(
      {this.username,
      this.email,
      this.password,
      this.profile,
      this.profilePic});
}

class Routine {
  int id;
  String title;
  Routine({this.id, this.title});

  factory Routine.fromJson(Map<String, dynamic> json) {
    return new Routine(
      id: json['id'],
      title: json['title'],
    );
  }
}
