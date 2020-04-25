import 'package:flutter/material.dart';
import 'package:clapme_client/screens/home_screen.dart';
import 'package:clapme_client/screens/login_screen.dart';
import 'package:clapme_client/screens/signup_screen.dart';
import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:clapme_client/screens/routine_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken');
    print('--------- 토큰! --------');
    print(accessToken);
    if (accessToken == null) {
      return false;
    } else {
      return true;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();

  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: HomeScreen(),
    routes: <String, WidgetBuilder>{
      '/signup': (BuildContext context) => new Signup(),
      '/login': (BuildContext context) => new Login(),
      '/onboarding': (BuildContext context) => new Onboarding(),
      '/routinelist': (BuildContext context) => new RoutineListScreen(),
    },
    initialRoute: isLogged ? '/routinelist' : '/',
  ));
}

final routes = {'/': (BuildContext context) => HomeScreen};
