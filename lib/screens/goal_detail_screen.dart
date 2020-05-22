import 'package:flutter/material.dart';
import 'package:clapme_client/models/goal_model.dart';
import 'package:clapme_client/services/goal_service.dart';

class GoalDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;
    print(arguments['goal']);
    final Goal goal = arguments['goal'];
    return Scaffold(body: Container(child: Text(goal.title)));
  }
}
