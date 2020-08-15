import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/utils/common_func.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:clapme_client/components/nofi_component.dart';

class AlarmService {
  NotificationDetails _platform;

  int _generateAlarmId(int id, String weekday) {
    // 알람 id 는 unique int 로만 관리 가능, 루틴 고유 id (DB id) + 요일 숫자 (월1 ~ 일7)
    final weekdayTable = {'mon': 1, 'tue': 2, 'wed': 3, 'thu': 4, 'fri': 5, 'sat': 6, 'sun': 7};
    return id + weekdayTable[weekday];
  }

  void _setAlarm(int id, String title, String body, String weekday, String strtime) async {
    await flutterLocalNotificationsPlugin.cancelAll();
    int alarmId = _generateAlarmId(id, weekday);
    Day day = convertWeekdayStringToDayEnum(weekday);

    int hour = int.parse(strtime.substring(0, 2));
    int minute = int.parse(strtime.substring(2));

    Time time = Time(hour, minute, 0);

    await FlutterLocalNotificationsPlugin()
        .showWeeklyAtDayAndTime(alarmId, title, body, day, time, this._platform);
  }


  void setWeeklyAlarms(int id, Routine routine) async {
    List<String> activeWeekdays = routine.getActiveWeekdays();
    String body = routine.title;

    activeWeekdays.forEach((String weekday) => {
      this._setAlarm(id, routine.title, body, weekday, routine.time)
    });
  }

  AlarmService() {
    var android = AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    var iOS = IOSNotificationDetails();
    _platform = NotificationDetails(android, iOS);
  }
}