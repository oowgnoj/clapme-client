import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './comment_screen.dart';
import '../models/s_goal_model.dart';
import '../models/s_thread_model.dart';

class AllGoals extends StatefulWidget {
  @override
  _AllGoalsState createState() => _AllGoalsState();
}

class _AllGoalsState extends State<AllGoals> {
  @override
  void initState() {
    super.initState();
    ScopedModel.of<ThreadModel>(context, rebuildOnChange: false).init();
  }

  void friendClicked(Goal friend) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Comment(friend);
        },
      ),
    );
  }

  Widget buildAllChatList() {
    return ScopedModelDescendant<ThreadModel>(
      builder: (context, child, model) {
        return ListView.builder(
          itemCount: model.friendList.length,
          itemBuilder: (BuildContext context, int index) {
            Goal friend = model.friendList[index];
            return ListTile(
              title: Text(friend.title),
              onTap: () => friendClicked(friend),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Goals'),
      ),
      body: buildAllChatList(),
    );
  }
}