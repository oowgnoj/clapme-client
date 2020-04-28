class User {
  final String email;
  final String password;
  final String username;
  final String image;
  final String status;

  User({this.email, this.password, this.username, this.image, this.status});

  factory User.fromJson(Map<String, String> json) {
    return User(
        email: json['user_id'],
        password: json['password'],
        username: json['user_name'],
        image: json['image'],
        status: json['status']);
  }
}

class Token {
  final String accessToken;

  Token({this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(accessToken: json['access-token']);
  }
}

class Login {
  final String accessToken;
  final String username;
  final String email;
  final dynamic profile;
  final dynamic profilePic;

  Login(
      {this.accessToken,
      this.username,
      this.email,
      this.profile,
      this.profilePic});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        email: json['email'],
        accessToken: json['access-token'],
        username: json['username'],
        profile: json['profile'],
        profilePic: json['profile_pic']);
  }
}
