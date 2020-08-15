import 'package:clapme_client/models/routine_with_success_model.dart';
import 'package:clapme_client/screens/new_routine_screen.dart';
import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:clapme_client/screens/routine_list_screen.dart';
import 'package:clapme_client/services/routine_success_service.dart';
import 'package:flutter/material.dart';
import 'package:clapme_client/theme/color_theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clapme_client/utils/alert_style.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  RoutineSuccessService service = RoutineSuccessService();
  MainTheme theme = MainTheme();
  DateTime now = DateTime.now();

  Future<List<RoutineWithSuccess>> routines;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    this.routines = this.service.getTodayRoutines();
  }

  Widget _header(now) {
    _buildText(text, size) {
      return Text(
        text,
        style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.display1,
            height: 1.5,
            fontSize: size,
            fontWeight: FontWeight.w100,
            color: this.theme.strongBlack),
      );
    }

    return Row(
      children: <Widget>[
        Container(
            child: _buildText(
                DateFormat(DateFormat.MONTH).format(now).toLowerCase(), 30.0)),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 30),
          child: Container(
              child: _buildText(
                  '${DateFormat(DateFormat.DAY).format(now)},', 60.0)),
        ),
        Container(child: _buildText(service.getCurrentDay(now), 30.0)),
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewRoutine()));
            },
            child: Icon(Icons.add, size: 20.0, color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 50.0),
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RoutineListScreen()));
              },
              child: Icon(Icons.list, size: 20.0, color: Colors.black87)),
        )
      ],
    );
  }

  Widget _statusText(length) {
    var plural = length > 0 ? 's' : '';

    _buildText(text, color) {
      return Text(text,
          style: GoogleFonts.raleway(
            textStyle: Theme.of(context).textTheme.display1,
            height: 1.5,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ));
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildText('You have ', this.theme.strongBlack),
            _buildText('$length', this.theme.orangeBrick),
            _buildText(' routine$plural for today', this.theme.strongBlack),
          ],
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 30),
            child: Row(
              children: <Widget>[
                _buildText('Track your day to understand you better!',
                    this.theme.strongBlack)
              ],
            )),
      ],
    );
  }

  Widget _routineSuccessButton(int id, bool success) {
    if (success) {
      return ClipOval(
          child: Container(
              height: 25.0,
              width: 25.0,
              color: Colors.black87,
              child: Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20.0,
              ))));
    } else {
      return GestureDetector(
          onTap: () {
            try {
              setState(() {
                this.routines = this.service.postRoutineSuccess(id);
              });
            } catch (e) {
              Alert(
                      context: context,
                      type: AlertType.none,
                      style: alertFailedStyle,
                      title: "Cannot Update",
                      desc: e.message)
                  .show();
            }
          },
          child: ClipOval(
              child: Container(
                  height: 25.0,
                  width: 25.0,
                  color: Colors.white,
                  child: Center(
                      child: Icon(
                    Icons.check,
                    color: this.theme.lightGrey,
                    size: 20.0,
                  )))));
    }
  }

  Widget _routineCard(id, title, time, color, success) {
    final hour = time.substring(0, 2);
    final minute = time.substring(2);

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
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: this._routineSuccessButton(id, success),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                child: Container(
                    child: Text('$hour:$minute',
                        style: GoogleFonts.raleway(
                          textStyle: Theme.of(context).textTheme.display1,
                          height: 1.5,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ))),
              ),
            ],
          )),
    );
  }

  Widget _routineList(BuildContext context, routines) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: routines.length,
          itemBuilder: (context, index) {
            RoutineWithSuccess r = routines[index];
            return _routineCard(r.id, r.title, r.time, r.color, r.success);
          },
          padding: EdgeInsets.symmetric(vertical: 16.0)),
    );
  }

  Widget _body() {
    return FutureBuilder<List<RoutineWithSuccess>>(
        future: this.routines,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                _statusText(snapshot.data.length),
                _routineList(context, snapshot.data)
              ],
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
              children: <Widget>[_header(this.now), _body()],
            )));
  }
}
