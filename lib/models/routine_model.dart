class Routine {
  String title;
  String color;
  String description;
  String time;
  bool alarm;
  bool mon;
  bool tue;
  bool wed;
  bool thu;
  bool fri;
  bool sat;
  bool sun;

  Routine(
      {this.title,
      this.time,
      this.alarm,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.sat,
      this.sun,
      this.color,
      this.description});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'alarm': alarm,
      'time': time,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
      'sat': sat,
      'sun': sun,
      'color': color,
      'description': description
    };
  }

  factory Routine.fromJson(dynamic json) {
    return Routine(
        title: json['title'],
        alarm: json['alarm'],
        time: json['time'],
        mon: json['mon'],
        tue: json['tue'],
        wed: json['wed'],
        thu: json['thu'],
        fri: json['fri'],
        sat: json['sat'],
        sun: json['sun'],
        color: json['color'],
        description: json['description']);
  }

  List<String> getActiveWeekdays() {
    List<String> activeDays = [];
    
    if (this.mon) activeDays.add('mon');
    if (this.tue) activeDays.add('tue');
    if (this.wed) activeDays.add('wed');
    if (this.thu) activeDays.add('thu');
    if (this.fri) activeDays.add('fri');
    if (this.sat) activeDays.add('sat');
    if (this.sun) activeDays.add('sun');

    return activeDays;
  }
}

class RoutineMaterial {
  List<RoutineColor> routineColor;

  RoutineMaterial({this.routineColor});
  factory RoutineMaterial.fromJson(Map<String, dynamic> json) {
    var colors = json['colors'] as List;
    var parsedColors = colors.map((e) => RoutineColor.fromJson(e)).toList();
    return RoutineMaterial(routineColor: parsedColors);
  }
}

class RoutineColor {
  String main;
  String sub;
  RoutineColor({this.main, this.sub});

  factory RoutineColor.fromJson(Map<String, dynamic> json) {
    return new RoutineColor(
      main: json['main'],
      sub: json['sub'],
    );
  }
}

class RoutineIdea {
  String title;
  String subTitle;
  String contents;
  String picUrl;
  List<RoutineIdeasRoutines> routines;

  RoutineIdea(
      {this.title, this.subTitle, this.contents, this.picUrl, this.routines});

  factory RoutineIdea.fromJson(Map<String, dynamic> json) {
    var routines = json['routines'] as List;
    var parsedRoutines =
        routines.map((e) => RoutineIdeasRoutines.fromJson(e)).toList();
    return new RoutineIdea(
        title: json['title'],
        subTitle: json['subtitle'],
        contents: json['contents'],
        picUrl: json['picUrl'],
        routines: parsedRoutines);
  }
}

class RoutineIdeasRoutines {
  String time;
  String title;
  RoutineIdeasRoutines({this.title, this.time});
  factory RoutineIdeasRoutines.fromJson(Map<String, dynamic> json) {
    return new RoutineIdeasRoutines(title: json['title'], time: json['time']);
  }
}

class RoutineRecommend {
  int main;
  int sub;
  RoutineRecommend({this.main, this.sub});

  factory RoutineRecommend.fromJson(Map<String, dynamic> json) {
    return new RoutineRecommend(
      main: json['id'],
      sub: json['title'],
    );
  }
}
