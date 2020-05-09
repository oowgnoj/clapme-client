import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/utils/common_func.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:clapme_client/components/nofi_component.dart';

Future<void> setWeeklyPush(List<Routine> list) async {
  await flutterLocalNotificationsPlugin.cancelAll();

  int alarmId = 0;

  for (var i = 0; i < list.length; i++) {
    Routine routine = list[i];
    List<String> weekdays = routine.getScheduledWeekdaysOfRoutine();
    for (var j = 0; j < weekdays.length; j++) {
      String weekday = weekdays[j];
      setLocalPush(alarmId, routine.title, weekday, routine.timeAt);
      alarmId++;
    }
  }
}

Future<void> setLocalPush(
    int id, String title, dynamic weekday, dynamic time) async {
  var android = AndroidNotificationDetails(
      'channelId', 'channelName', 'channelDescription');
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);

  String body = title + ' 할 시간이에요!';
  weekday = convertWeekdayStringToDayEnum(weekday);
  int hour = time >= 1000
      ? int.parse(time.toString().substring(0, 2))
      : int.parse(time.toString().substring(0, 1));
  int minute = time >= 1000
      ? int.parse(time.toString().substring(2))
      : int.parse(time.toString().substring(1));
  time = Time(hour, minute, 0);

  await FlutterLocalNotificationsPlugin()
      .showWeeklyAtDayAndTime(id, title, body, weekday, time, platform);
}
