import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewOnboarding extends StatefulWidget {
  @override
  _NewOnboardingState createState() => _NewOnboardingState();
}

class _NewOnboardingState extends State<NewOnboarding> {
  int currentPage = 0;
  Color StrongBlue = Color.fromRGBO(39, 47, 89, 1);
  Color PureWhite = Color.fromRGBO(255, 255, 255, 1);
  goNextPage() {
    if (currentPage == 2) {
      return Navigator.of(context).pushNamed('/login');
    }
    setState(() {
      currentPage = currentPage + 1;
    });
  }

  List titles = [
    'Get routines from great people',
    'Organize your daily routine',
    'Go into your System'
  ];
  Widget titleText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Text(
            titles[currentPage],
            style: TextStyle(
                fontSize: 24, color: StrongBlue, fontWeight: FontWeight.bold),
          )),
    );
  }

  List images = ['assets/onboarding-1.png', 'assets/onboarding-2.png'];
  Widget imageContainer() {
    return new Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: new BoxDecoration(
        image: new DecorationImage(image: new AssetImage(images[currentPage])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: PureWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
            child: Text(
              titles[currentPage],
              style: TextStyle(
                  fontSize: 30, color: StrongBlue, fontWeight: FontWeight.bold),
            ),
          ),
          if (currentPage < 2)
            Container(
              child: imageContainer(),
            ),
          if (currentPage == 2)
            Lottie.asset('assets/onboarding-3.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7),
          RaisedButton(
              onPressed: () => goNextPage(),
              color: PureWhite,
              child: Text('Next')),
        ],
      ),
    );
  }
}
