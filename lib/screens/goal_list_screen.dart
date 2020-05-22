import 'package:flutter/material.dart';
import 'package:clapme_client/services/goal_service.dart';
import 'package:clapme_client/models/goal_model.dart';
import 'package:clapme_client/screens/goal_detail_screen.dart';

class GoalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder(
          future: fetchUserGoalList('accepted'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Goal> list = snapshot.data;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/goaldetail',
                              arguments: {'goal': list[index]});
                        },
                        child: Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(5, 121, 126, 1)))),
                            child: Text(
                              '${list[index].title}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )),
                      );
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
