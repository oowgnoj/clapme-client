class RoutineWithSuccess {
  int id;
  String title;
  bool alarm;
  String time;
  String color;
  bool success;

  RoutineWithSuccess({
    this.id,
    this.title,
    this.alarm,
    this.time,
    this.color,
    this.success
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'alarm': alarm,
      'time': time,
      'color': color,
      'success': success
    };
  }

  factory RoutineWithSuccess.fromJson(dynamic json) {
    return RoutineWithSuccess(
        id: json['id'],
        title: json['title'],
        alarm: json['alarm'],
        time: json['time'],
        color: json['color'],
        success: json['success']
    );
  }
}
