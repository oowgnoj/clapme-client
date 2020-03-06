import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/services/routine_service.dart';


class RoutineListScreen extends StatefulWidget {
  @override
  _RoutineListScreenState createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 6));
  DateTime endDate = DateTime.now().add(Duration(days: 0));
  DateTime selectedDate = DateTime.now();
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
  ];

  List<Routine> routineList = [Routine(
    id: 1,
    userId: 2,
    goalId: 3,
    title: '샘플 루틴',
    mon: true,
    tue: false,
    wed: false,
    thu: false,
    fri: false,
    sat: false,
    sun: false,
    timeAt: 9,
    createdAt: DateTime.now()
  )];

  @override
  initState() {
    super.initState();
    print('실행되니?');
    fetchDayRoutine()
        .then((result){routineList = result;},
        onError: (error) {
          print(error);
          var temp = Routine(
            id: 1,
            userId: 2,
            goalId: 3,
            title: '샘플 루틴 from fetch error',
            mon: true,
            tue: false,
            wed: false,
            thu: false,
            fri: false,
            sat: false,
            sun: false,
            timeAt: 100,
            createdAt: DateTime.now()
          );
          routineList = [temp];
    });
  }

  onSelect(data) {
    print("Selected Date -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
//      child: Text(monthName,
//          style:
//          TextStyle(fontSize: 17, fontWeight: FontWeight.w300, color: Colors.black87)),
      padding: EdgeInsets.only(top: 11, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 6,
        height: 6,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF3EBACE)),
      ),
    ]);
  }

  dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: fontColor);
    TextStyle selectedStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 13, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(), style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView (
              children: <Widget>[CalendarStrip(
            startDate: startDate,
            endDate: endDate,
            onDateSelected: onSelect,
            dateTileBuilder: dateTileBuilder,
            iconColor: Colors.black87,
            monthNameWidget: _monthNameWidget,
            markedDates: markedDates,
            containerDecoration: BoxDecoration(color: Colors.white),
          ), ...routineList.map((routine) => Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(routine.title),
              subtitle: Text(routine.timeAt.toString()),
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
      )).toList(),
      ])),
    );
  }
}


