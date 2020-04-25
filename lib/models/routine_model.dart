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
}
