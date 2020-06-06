import 'package:clapme_client/models/reaction_model.dart';

class Comment {
  int commentId;
  int userId;
  int goalId;
  String userName;
  String content;
  int timestamp;
  List<Reaction> reactions;

  Comment(
      {this.commentId,
      this.userId,
      this.goalId,
      this.userName,
      this.content,
      this.timestamp,
      this.reactions});

  factory Comment.fromJson(dynamic json) {
    return Comment(
        commentId: json['id'],
        userId: json['user_id'],
        goalId: json['goal_id'],
        userName: json['user_name'],
        content: json['content'],
        timestamp: json['timestamp'],
        reactions: json['reactions']);
  }
}
