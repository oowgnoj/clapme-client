import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Unlike Java, Dart doesn’t have the keywords public, protected, and private.
// If an identifier starts with an underscore _, it’s private to its library.

class ApiHelper {
  String _baseUrl = 'http://15.164.96.238:5000';

  Future<String> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
    // return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJteW5zbWFlaXMiLCJlbWFpbCI6ImhlbGxvQGdtYWlsLmNvbSIsInByb2ZpbGUiOm51bGwsInBpY191cmwiOm51bGx9.O2dKwUdOjVrQBnkUNJIupUoo5wrv6tiTYzjtRN6LwHA';
  }

  Future<dynamic> post(String uri, dynamic body) async {
    uri = '${this._baseUrl}/$uri';
    String accessToken = await this._getAccessToken();

    print(' ---- API POST ---- ');
    print(uri);
    print(accessToken);

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': accessToken
    };

    var jsonBody = json.encode(body);

    return await http.post(uri, headers: headers, body: jsonBody);
  }

  Future<dynamic> get(String uri, [String params]) async {
    uri = params != null
        ? '${this._baseUrl}/$uri?$params'
        : '${this._baseUrl}/$uri';

    String accessToken = await this._getAccessToken();

    print(' ---- API GET ---- ');
    print(uri);
    print(accessToken);

    var headers = {'Authorization': accessToken};

    return await http.get(uri, headers: headers);
  }
}
