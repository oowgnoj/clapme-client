import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clapme_client/models/user_model.dart';

var server = 'http://15.164.96.238:5000';

Future<bool> fetchLogin(email, password) async {
  var body = jsonEncode({'email': email, 'password': password});

  final response = await http.post('$server/login/',
      body: body, headers: {'Content-Type': "application/json"});

  if (response.statusCode == 200) {
    var decoded = Token.fromJson(json.decode(response.body));
    return true;
  } else {
    return false;
  }
}

Future<User> fetchSignup(email, password, username) async {
  final response = await http.post('$server/signin',
      body: {email: email, password: password, username: username});

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to signup');
  }
}
