import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:clapme_client/models/routine_with_success_model.dart';
import 'package:clapme_client/utils/api_helper.dart';

class RoutineSuccessService {
  ApiHelper _api = ApiHelper();

  String getCurrentDateStr(DateTime now) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  String getCurrentDay(DateTime now) {
    const week = {
      'Monday': 'mon',
      'Tuesday': 'tue',
      'Wednesday': 'wed',
      'Thursday': 'thu',
      'Friday': 'fri',
      'Saturday': 'sat',
      'Sunday': 'sun'
    };

    String day = DateFormat(DateFormat.WEEKDAY).format(now);
    return week[day];
  }

  Future<List<RoutineWithSuccess>> getTodayRoutines(
      [String dateStr, String day]) async {
    final now = DateTime.now();
    dateStr = dateStr ?? this.getCurrentDateStr(now);
    day = day ?? this.getCurrentDay(now);

    String params = 'dateStr=$dateStr&day=$day';

    final response = await this._api.get('routines', params);

    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      List<RoutineWithSuccess> routines = [];

      result['routines']
          .forEach((r) => routines.add(RoutineWithSuccess.fromJson(r)));

      return routines;
    } else {
      String message = 'Network Error, Please try again.';

      if (response.statusCode == 401)
        message = 'Your session has timed out. Please login again.';

      throw Exception(message);
    }
  }

  Future<List<RoutineWithSuccess>> postRoutineSuccess(int id,
      [String dateStr, String day]) async {
    final now = DateTime.now();
    dateStr = dateStr ?? this.getCurrentDateStr(now);
    day = day ?? this.getCurrentDay(now);

    var body = {'id': id, 'dateStr': dateStr, 'day': day};

    final response = await this._api.post('routine-success', body);

    if (response.statusCode == 200) {
      List<RoutineWithSuccess> result = (json.decode(response.body) as List)
          .map((r) => RoutineWithSuccess.fromJson(r))
          .toList();

      return result;
    } else {
      String message = 'Network Error, Please try again.';

      if (response.statusCode == 401)
        message = 'Your session has timed out. Please login again.';

      if (response.statusCode == 409) message = 'Already up to date';

      throw Exception(message);
    }
  }
}
