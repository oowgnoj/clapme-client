import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TimePicker extends StatelessWidget {
  // super constructor
  TimePicker({Key key, this.setAlarmTime}) : super(key: key);
  final Function(DateTime) setAlarmTime;

  // constructor :

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      child: CupertinoDatePicker(
          backgroundColor: Color.fromRGBO(249, 249, 249, 1),
          mode: CupertinoDatePickerMode.time,
          use24hFormat: false,
          onDateTimeChanged: (DateTime changedTime) {
            setAlarmTime(changedTime);
          }),
    );
  }
}
