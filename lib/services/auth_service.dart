import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:clapme_client/models/user_model.dart';

final storage = new FlutterSecureStorage();
var server = 'http://15.164.96.238:5000';

Future<bool> fetchLogin(email, password) async {
  final response = await http
      .post('$server/login', body: {email: email, password: password});

  print(response.statusCode);

  if (response.statusCode == 200) {
    var decoded = Token.fromJson(json.decode(response.body));
    await storage.write(key: 'accessToken', value: decoded.accessToken);
    return true;
  } else {
    return false;
  }
}

Future<User> fetchSignup(email, password, username) async {
  final response = await http.post('$server/signin',
      body: {email: email, password: password, username: username});

  print(response.statusCode);

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to signup');
  }
}
