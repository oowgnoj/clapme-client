import 'package:clapme_client/models/user_model.dart';

class Message{
  final User user_info;
  final int goal_id;
  final String comment;

  Message(this.user_info,this.goal_id,this.comment);
}