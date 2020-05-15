import 'package:clapme_client/models/routine_model.dart';

class Schedule {
  List<Routine> mon;
  List<Routine> tue;
  List<Routine> wed;
  List<Routine> thu;
  List<Routine> fri;
  List<Routine> sat;
  List<Routine> sun;

  initialize() {
    this.mon = [];
    this.tue = [];
    this.wed = [];
    this.thu = [];
    this.fri = [];
    this.sat = [];
    this.sun = [];
    return this;
  }

  Schedule(
      {this.mon, this.tue, this.wed, this.thu, this.fri, this.sat, this.sun});

  setSchedule(Routine routine, String dayOfWeek) {
    switch (dayOfWeek) {
      case 'mon':
        this.mon.add(routine);
        return;
      case 'tue':
        this.tue.add(routine);
        return;
      case 'wed':
        this.wed.add(routine);
        return;
      case 'thu':
        this.thu.add(routine);
        return;
      case 'fri':
        this.fri.add(routine);
        return;
      case 'sat':
        this.sat.add(routine);
        return;
      case 'sun':
        this.sun.add(routine);
        return;
    }
  }

  countRoutines(String dayOfWeek) {
    switch (dayOfWeek) {
      case 'mon':
        return this.mon.length;
      case 'tue':
        return this.tue.length;
      case 'wed':
        return this.wed.length;
      case 'thu':
        return this.thu.length;
      case 'fri':
        return this.fri.length;
      case 'sat':
        return this.sat.length;
      case 'sun':
        return this.sun.length;
    }
  }

  getScheduledWeekdays() {
    List<String> weekdays = [];
    if (this.mon.length > 0) weekdays.add('mon');
    if (this.tue.length > 0) weekdays.add('tue');
    if (this.wed.length > 0) weekdays.add('wed');
    if (this.thu.length > 0) weekdays.add('thu');
    if (this.fri.length > 0) weekdays.add('fri');
    if (this.sat.length > 0) weekdays.add('sat');
    if (this.sun.length > 0) weekdays.add('sun');
    return weekdays;
  }
}
