import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/screens/today_screen.dart';
import 'package:clapme_client/services/routine_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutineListScreen extends StatefulWidget {
  @override
  _RoutineListScreenState createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  RoutineService service = RoutineService();
  Future<List<Routine>> routines;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    this.routines = this.service.getRoutines();
  }

  Widget _header() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => TodayScreen()
            )
        );
      },
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
          child: Icon(Icons.arrow_left, size: 30.0),
        ),
        Text('today',
            style: GoogleFonts.playfairDisplay(
              textStyle: Theme.of(context).textTheme.display1,
              height: 1.5,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ))
      ]),
    );
  }

  Widget _routineCard(title, color, mon, tue, wed, thu, fri, sat, sun) {
    _conditionallyBuildWeekday(text, isActive) {
      var color = isActive ? Colors.white : Color.fromRGBO(12, 13, 14, 0.2);

      return Padding(
        padding: const EdgeInsets.fromLTRB(3.0, 25.0, 0, 0),
        child: Text(text,
            style: GoogleFonts.libreFranklin(
              textStyle: Theme.of(context).textTheme.display1,
              height: 1.5,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: color,
            )),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(int.parse(color)),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Container(
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        textStyle: Theme.of(context).textTheme.display1,
                        height: 1.5,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 18, 0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _conditionallyBuildWeekday('M', mon),
                        _conditionallyBuildWeekday('T', tue),
                        _conditionallyBuildWeekday('W', wed),
                        _conditionallyBuildWeekday('T', thu),
                        _conditionallyBuildWeekday('F', fri),
                        _conditionallyBuildWeekday('S', sat),
                        _conditionallyBuildWeekday('S', sun)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _routineList(BuildContext context, routines) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: routines.length,
          itemBuilder: (context, index) {
            Routine r = routines[index];
            return _routineCard(r.title, r.color, r.mon, r.tue, r.wed, r.thu,
                r.fri, r.sat, r.sun);
          },
          padding: EdgeInsets.symmetric(vertical: 16.0)),
    );
  }

  Widget _body() {
    return FutureBuilder<List<Routine>>(
        future: this.routines,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[_routineList(context, snapshot.data)],
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline, size: 40.0);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
            child: Column(
              children: <Widget>[_header(), _body()],
            )));
  }
}
