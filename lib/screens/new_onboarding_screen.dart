import 'package:flutter/material.dart';

class NewOnboarding extends StatefulWidget {
  @override
  _NewOnboardingState createState() => _NewOnboardingState();
}

class _NewOnboardingState extends State<NewOnboarding> {
  int currentPage = 0;

  goNextPage() {
    if (currentPage == 3) {
      return Navigator.of(context).pushNamed('/login');
    }
    setState(() {
      currentPage = currentPage + 1;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Text(this.currentPage.toString(),
                style: TextStyle(fontSize: 100))),
        RawMaterialButton(child: Text('click'), onPressed: this.goNextPage)
      ],
    ));
  }
}
