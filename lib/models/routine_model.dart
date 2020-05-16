class Routine {
  int id;
  /* int userId; */
  int goalId;
  String title;
  bool mon;
  bool tue;
  bool wed;
  bool thu;
  bool fri;
  bool sat;
  bool sun;
  int timeAt;
  // String createdAt;

  // successes 추가해야함

  Routine({
    this.id,
    /* this.userId, */
    this.goalId,
    this.title,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun,
    this.timeAt,
    // this.createdAt
    // successes 추가해야함
  });

  factory Routine.fromJson(dynamic json) {
    return Routine(
        id: json['id'],
        /* userId: json['userId'], */
        goalId: json['goal_id'],
        title: json['title'],
        mon: json['mon'],
        tue: json['tue'],
        wed: json['wed'],
        thu: json['thu'],
        fri: json['fri'],
        sat: json['sat'],
        sun: json['sun'],
        timeAt: json['time_at']);
    // createdAt: json['created']);
  }

  isScheduled(String dayOfWeek) {
    // 해당 루틴에 특정 요일 알람이 설정되었는지 여부 반환
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

  getScheduledWeekdaysOfRoutine() {
    // 해당 루틴 알람 요일들 반환
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

// single recommended routine
class RoutineRecommend {
  int id;
  String title;
  RoutineRecommend({this.id, this.title});

  factory RoutineRecommend.fromJson(Map<String, dynamic> json) {
    return new RoutineRecommend(
      id: json['id'],
      title: json['title'],
    );
  }
}
