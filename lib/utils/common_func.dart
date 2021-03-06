import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String convertDayBooltoStr(Map<String, dynamic> daysBool) {
  // true 인 요일만 daysStr에 추가
  List<String> daysStr = [];
  daysBool.forEach((day, isTrue) => isTrue ? daysStr.add(day) : null);
  if (daysStr.length == 7 || daysStr.length == 5 || daysStr.length == 2) {
    if (daysStr.length == 7) {
      return 'everyday';
    }
    if (daysStr.length == 2) {
      if (daysStr.contains('sat') && daysStr.contains('sun')) {
        return 'weekends';
      }
    }
    if (daysStr.length == 5) {
      if (!daysStr.contains('sat') && !daysStr.contains('sun')) {
        return 'weekdays';
      }
    }
  }
  return daysStr.join(',').toString();
}

Day convertWeekdayStringToDayEnum(String weekday) {
  switch (weekday) {
    case 'mon':
      return Day.Monday;
    case 'tue':
      return Day.Tuesday;
    case 'wed':
      return Day.Wednesday;
    case 'thu':
      return Day.Thursday;
    case 'fri':
      return Day.Friday;
    case 'sat':
      return Day.Saturday;
    case 'sun':
      return Day.Sunday;
  }
}

String convertDateTimeToHHMMString(DateTime datetime) {
  var hour = datetime.hour.toString();
  var min = datetime.minute.toString();
  if (hour.length == 1) {
    hour = '0' + hour;
  }
  if (min.length == 1) {
    min = '0' + min;
  }
  return hour + min;
}

dynamic myDateSerializer(dynamic object) {
  String parsedTime;
  if (object is DateTime) {
    String parsedTime = convertDateTimeToHHMMString(object);
    return parsedTime;
  }
}
