import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/services/routine_service.dart';
import 'package:intl/intl.dart';

class RoutineListScreen extends StatefulWidget {
  @override
  _RoutineListScreenState createState() => _RoutineListScreenState();
}

class _RoutineListScreenState extends State<RoutineListScreen> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 6));
  DateTime endDate = DateTime.now().add(Duration(days: 0));
  DateTime selectedDate = DateTime.now();
  String selectedDayOfWeek =
      DateFormat('E').format(DateTime.now()).toLowerCase();

  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
  ];

  Future<List<Routine>> routineList;

  @override
  initState() {
    super.initState();
    routineList =
        fetchDayRoutine(DateFormat('E').format(DateTime.now()).toLowerCase());
  }

  onSelect(data) async {
    setState(() => {
          selectedDate = data,
          selectedDayOfWeek = DateFormat('E').format(data).toLowerCase(),
          routineList = fetchDayRoutine(selectedDayOfWeek)
        });

    print("Selected Date -> $data $selectedDayOfWeek");
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

  _buildRoutineCard(Routine routine) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text(routine.title), // 타이틀 오면 바꿀것
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(children: <Widget>[
        CalendarStrip(
          startDate: startDate,
          endDate: endDate,
          onDateSelected: onSelect,
          dateTileBuilder: dateTileBuilder,
          iconColor: Colors.black87,
          monthNameWidget: _monthNameWidget,
          markedDates: markedDates,
          containerDecoration: BoxDecoration(color: Colors.white),
        ),
        FutureBuilder(
            future: routineList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Routine routine = snapshot.data[index];
                    return _buildRoutineCard(routine);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            })
      ])),
    );
  }
}
