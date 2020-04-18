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
