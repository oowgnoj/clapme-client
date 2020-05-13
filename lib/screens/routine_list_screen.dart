import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/models/schedule_model.dart';
import 'package:clapme_client/services/routine_service.dart';
import 'package:intl/intl.dart';
import 'package:clapme_client/screens/routine_list_weekly_screen.dart';

class RoutineListScreen extends StatefulWidget {
  @override
  _RoutineListScreenState createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  // 달력뷰 데이터
  DateTime startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime endDate = DateTime.now().add(Duration(days: 0));
  DateTime selectedDate = DateTime.now();
  List<DateTime> markedDates;

  String selectedDayOfWeek =
      DateFormat('E').format(DateTime.now()).toLowerCase(); // 선택된 요일
  Future<List<Routine>> weeklyRoutines; // 주간 루틴 정보
  Schedule weeklySchedule; // 주단위 요일별 루틴 여부

  @override
  initState() {
    super.initState();
    weeklyRoutines =
        fetchDayRoutine(DateFormat('E').format(DateTime.now()).toLowerCase());
  }

  onSelect(data) async {
    setState(() => {
          selectedDate = data,
          selectedDayOfWeek = DateFormat('E').format(data).toLowerCase(),
        });
  }

  List<DateTime> getScheduledDatetimes() {
    // 달력뷰에 포함되는 날짜 중 루틴이 등록된 datetime 반환
    var day = startDate;
    List<DateTime> datetimes = [];

    while (day.compareTo(endDate) < 0) {
      String dayOfWeek = DateFormat('E').format(day).toLowerCase();
      if (weeklySchedule.countRoutines(dayOfWeek) > 0) datetimes.add(day);
      day = day.add(new Duration(days: 1));
    }
    return datetimes;
  }

  setWeeklySchedule(list) {
    // 주간 루틴 정보 weeklyRoutines 토대로 요일별 루틴 여부를 관리하는 스케쥴 업데이트
    Schedule schedule = new Schedule().initialize();
    list.forEach((routine) => {
          routine
              .getScheduledWeekdaysOfRoutine()
              .forEach((weekday) => schedule.setSchedule(routine, weekday))
        });
    weeklySchedule = schedule;
  }

  List<Routine> getSelectedRoutine(list) {
    // 선택한 요일에 해당하는 루틴 리스트 반환
    return list
        .where((data) => data.isScheduled(selectedDayOfWeek) == true)
        .toList();
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 6,
        height: 6,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(0xFF3EBACE)),
      ),
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 13, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    } else {
      _children.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(left: 1, right: 1),
          width: 6,
          height: 6,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
      ]));
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  _blank(monthName) {
    return Container(
      padding: EdgeInsets.only(top: 11, bottom: 4),
    );
  }

  _buildRoutineCard(Routine routine) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text(routine.title),
            subtitle: Text(routine.timeAt >= 1000
                ? routine.timeAt.toString().substring(0, 2) +
                    ' : ' +
                    routine.timeAt.toString().substring(2)
                : routine.timeAt.toString().substring(0, 1) +
                    ' : ' +
                    routine.timeAt.toString().substring(1)),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('complete !'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: weeklyRoutines,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              setWeeklySchedule(snapshot.data);
              markedDates = getScheduledDatetimes();

              return Container(
                  child: ListView(children: <Widget>[
                CalendarStrip(
                  startDate: startDate,
                  endDate: endDate,
                  onDateSelected: onSelect,
                  dateTileBuilder: dateTileBuilder,
                  iconColor: Colors.black87,
                  monthNameWidget: _blank,
                  markedDates: markedDates,
                  containerDecoration: BoxDecoration(color: Colors.white),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: getSelectedRoutine(snapshot.data).length,
                  itemBuilder: (BuildContext context, int index) {
                    Routine routine = getSelectedRoutine(snapshot.data)[index];
                    return _buildRoutineCard(routine);
                  },
                )
              ]));
            } else if (snapshot.hasError) {}
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RoutineListWeekly(schedule: weeklySchedule)));
                // Navigator.of(context).pushNamed('/routinelistWeekly');
              },
              child: Icon(
                Icons.check,
                color: Color(0xff7ACBAA),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Navigator.of(context).pushNamed('/onboarding');
            },
            child: Icon(Icons.add),
            backgroundColor: Color(0xff7ACBAA),
          ),
        ],
      ),
    );
  }
}
