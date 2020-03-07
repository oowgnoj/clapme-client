import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TimePicker extends StatelessWidget {
  // super constructor
  TimePicker({Key key, this.setAlarmTime}) : super(key: key);
  final Function(Duration) setAlarmTime;

  // constructor :

  @override
  Widget build(BuildContext context) {
    print(setAlarmTime);
    return CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hm,
        onTimerDurationChanged: (Duration changedTime) {
          print(changedTime);
        });
  }
}

// --- screen ---

// screenvalue = Timepicker.getChangedTime()
// setState() {
//   alarmTime
// }

//  Initializers are executed before the constructor,
// but this is only allowed to be accessed
//  after the call to the super constructor
// (implicit in your example) was completed.
/*

// Therefore only in the constructor body 
// (or later) access to this is allowed.


constructor : class 가 생성될 때 초기화를 위해 쓰는 코드 block


class A (name) {

  constructor(super) {
    
    this.name = name
    this.a = a
  }


}




*/
