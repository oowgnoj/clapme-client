// class Goal {
//   String id;
//   String description;
//   String interval;
//   String times;
//   String title;
//   String thumbnail;

//   Goal(
//       {this.id,
//       this.description,
//       this.interval,
//       this.times,
//       this.title,
//       this.thumbnail});

//   factory Goal.fromJson(Map<String, String> json) {
//     return Goal(
//         id: json['goal_id'],
//         description: json['description'],
//         interval: json['interval'],
//         times: json['times'],
//         title: json['title'],
//         thumbnail: json['thumbnail']);
//   }
// }

class Goal {
  int id;
  String description;
  String interval;
  int times;
  String title;
  String thumbnail;

  Goal({
    this.description,
    this.interval,
    this.times,
    this.title,
    this.thumbnail,
    this.id,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
        id: json['id'],
        description: json['description'],
        interval: json['interval'],
        times: json['times'],
        title: json['title'],
        thumbnail: json['thumbnail']);
  }
}
