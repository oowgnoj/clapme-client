import 'package:http/http.dart' as http;

var server = 'http://clapme.server.com';

Future<http.Response> fetchDayRoutine() {
  return http.get('$server/routine/');
}