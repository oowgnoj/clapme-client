import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'dart:convert';

import './s_goal_model.dart';
import './s_message_model.dart';

class ThreadModel extends Model {
  List<Goal> Goals = [
    Goal('만보 걷기', 1),
    Goal('토요일 저녁 자전거', 2),
    Goal('물 마시기', 3),
    Goal('알고리즘 풀기', 4),
    Goal('푹 쉬기', 5),
  ];

  Goal currentGoal;
  List<Goal> friendList = List<Goal>();
  List<Message> messages = List<Message>();
  SocketIO socketIO;

  void init() {
    currentGoal = Goals[0];
    friendList =
        Goals.where((Goal) => Goal.goalId != currentGoal.goalId).toList();

    socketIO = SocketIOManager().createSocketIO(
        'http://10.0.2.2:8000', '/',
        query: 'goalId=${currentGoal.goalId}');
    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
          data['content'], data['sendergoalId'], data['receivergoalId']));
      notifyListeners();
    });

    socketIO.connect();
  }

  void sendMessage(String text, int goalId) {
    messages.add(Message(text, currentGoal.goalId, goalId));
    socketIO.sendMessage(
      'send_message',
      json.encode({
        'receivergoalId': currentGoal.goalId,
        'sendergoalId': currentGoal.goalId,
        'content': text,
      }),
    );
    notifyListeners();
  }

  List<Message> getMessagesForGoalId(int goalId) {
    return messages
        .where((msg) => msg.senderID == goalId || msg.receiverID == goalId)
        .toList();
  }
}