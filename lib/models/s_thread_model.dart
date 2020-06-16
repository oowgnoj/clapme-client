import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'dart:convert';

import './s_goal_model.dart';
import './s_message_model.dart';
import './user_model.dart';

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

  User tmpUser = User(email: 'hello', password: '12345', username: 'hello', image: '', status: '');

  void init() {
    currentGoal = Goals[0];
    friendList =
        Goals.where((Goal) => Goal.goalId != currentGoal.goalId).toList();

    // connection
    socketIO = SocketIOManager().createSocketIO(
        'http://15.164.96.238:5000', '/goal');
    socketIO.init();

    socketIO.subscribe('connect', () {
      socketIO.sendMessage('joined', json.encode({
        'goal_id':  11
      }));
    });

    socketIO.subscribe('comment', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);

      //user_info 는 user 객체
      messages.add(Message(
          data['user_info'], data['goal_id'], data['comment']));
      notifyListeners();
    });

    socketIO.connect();
  }

  void sendMessage(String text, int goalId) {
    messages.add(Message(tmpUser, currentGoal.goalId, text));
    socketIO.sendMessage(
      'comment',
      json.encode({
        'user_id': 2, // tmpUser.user_id
        'goal_id': 11,
        'comment': text,
      }),
    );
    notifyListeners();
  }

  List<Message> getMessagesForGoalId(int goalId) {
    return messages
        .where((msg) => true)
        .toList();
  }
}