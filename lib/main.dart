import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clapme_client/screens/home_screen.dart';
import 'package:clapme_client/screens/login_screen.dart';
import 'package:clapme_client/screens/signup_screen.dart';
import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:clapme_client/screens/goal_list_screen.dart';
import 'package:clapme_client/screens/routine_list_screen.dart';
import 'package:clapme_client/screens/routine_list_weekly_screen.dart';
import 'package:clapme_client/screens/goal_detail_screen.dart';
import 'package:clapme_client/screens/mypage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          '/onboarding': (BuildContext context) => new Onboarding(),
          // '/routinelist': (BuildContext context) => new RoutineListScreen(),
          '/routinelist': (BuildContext context) => new GoalList(),
          '/goaldetail': (BuildContext context) => new GoalDetail(),
        },
        initialRoute: widget.isLogged ? '/routinelist' : '/',
        home: widget.isLogged
            ? DefaultTabController(
                length: 3,
                child: Scaffold(
                  bottomNavigationBar: new TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.list)),
                      Tab(icon: Icon(Icons.flag)),
                      Tab(icon: Icon(Icons.account_box)),
                    ],
                    labelColor: Color(0xff7ACBAA),
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.all(5.0),
                    indicatorColor: Color(0xff7ACBAA),
                  ),
                  body: TabBarView(
                    children: [RoutineListScreen(), GoalList(), MyPage()],
                  ),
                ),
              )
            : HomeScreen());
  }
}

final routes = {'/': (BuildContext context) => HomeScreen};
