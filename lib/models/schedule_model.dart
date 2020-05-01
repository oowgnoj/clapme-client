class Schedule {
  bool mon;
  bool tue;
  bool wed;
  bool thu;
  bool fri;
  bool sat;
  bool sun;

  Schedule(
      {this.mon, this.tue, this.wed, this.thu, this.fri, this.sat, this.sun});

  setSchedule(String dayOfWeek) {
    switch (dayOfWeek) {
      case 'mon':
        this.mon = true;
        return;
      case 'tue':
        this.tue = true;
        return;
      case 'wed':
        this.wed = true;
        return;
      case 'thu':
        this.thu = true;
        return;
      case 'fri':
        this.fri = true;
        return;
      case 'sat':
        this.sat = true;
        return;
      case 'sun':
        this.sun = true;
        return;
    }
  }

  isScheduled(String dayOfWeek) {
    switch (dayOfWeek) {
      case 'mon':
        return this.mon;
      case 'tue':
        return this.tue;
      case 'wed':
        return this.wed;
      case 'thu':
        return this.thu;
      case 'fri':
        return this.fri;
      case 'sat':
        return this.sat;
      case 'sun':
        return this.sun;
    }
  }

  getScheduledWeekdays() {
    List<String> weekdays = [];
    if (this.mon == true) weekdays.add('mon');
    if (this.tue == true) weekdays.add('tue');
    if (this.wed == true) weekdays.add('wed');
    if (this.thu == true) weekdays.add('thu');
    if (this.fri == true) weekdays.add('fri');
    if (this.sat == true) weekdays.add('sat');
    if (this.sun == true) weekdays.add('sun');
    return weekdays;
  }
}
