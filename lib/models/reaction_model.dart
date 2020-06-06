class Reaction {
  int reactionId;
  int userId;
  int commentId;
  int successId;
  String userName;
  String type;

  Reaction(
      {this.reactionId,
      this.userId,
      this.commentId,
      this.successId,
      this.type,
      this.userName});

  factory Reaction.fromJson(dynamic json) {
    return Reaction(
        reactionId: json['reaction_id'],
        userId: json['user_id'],
        commentId: json['comment_id'],
        successId: json['success_id'],
        type: json['type'],
        userName: json['user_name']);
  }
}
