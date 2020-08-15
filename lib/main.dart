import 'dart:async';

import 'package:clapme_client/screens/today_screen.dart';
import 'package:flutter/material.dart';
import 'package:clapme_client/screens/home_screen.dart';
import 'package:clapme_client/screens/login_screen.dart';
import 'package:clapme_client/screens/signup_screen.dart';
import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:clapme_client/screens/goal_list_screen.dart';
import 'package:clapme_client/screens/routine_list_screen.dart';
import 'package:clapme_client/screens/routine_list_weekly_screen.dart';
import 'package:clapme_client/screens/main_screen.dart';
import 'package:clapme_client/screens/new_routine_screen.dart';
import 'package:clapme_client/screens/goal_detail_screen.dart';
import 'package:clapme_client/screens/mypage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clapme_client/screens/new_onboarding_screen.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:clapme_client/components/nofi_component.dart';

class Auth {
  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      return false;
    } else {
      return true;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* setLocalPush(); */

  // notification setting
  var initAndroidSetting = AndroidInitializationSettings('app_icon');
  var initIosSetting = IOSInitializationSettings();
  var initSetting = InitializationSettings(initAndroidSetting, initIosSetting);
  await FlutterLocalNotificationsPlugin().initialize(initSetting);

  // auth token check
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();

  runApp(MyApp(isLogged));
}

class MyApp extends StatefulWidget {
  MyApp(this.isLogged);
  final bool isLogged;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) => new Signup(),
          '/login': (BuildContext context) => new Login(),
          '/onboarding': (BuildContext context) => new NewOnboarding(),
          '/today': (BuildContext context) => new TodayScreen(),
          '/routine': (BuildContext context) => new RoutineListScreen()
        },
        initialRoute: widget.isLogged ? '/today' : '/onboarding',
        home: Scaffold(body: NewOnboarding()));
  }
}
