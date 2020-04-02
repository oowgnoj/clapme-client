import 'package:flutter/material.dart';

class RecommendList extends StatefulWidget {
  // construcort -> super,
  // static 한 것에는 super constructor 필요 없음,

  RecommendList(
      {@required this.list,
      @required this.mainColor,
      this.setGoalName,
      this.setAlarmTime});
  final list;
  final mainColor;
  final Function(String) setGoalName;
  final Function(Duration) setAlarmTime;

  @override
  _RecommendListState createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList> {
  @override
  Widget build(BuildContext context) {
    print(widget.list);
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              widget.setGoalName(widget.list[index]);
            },
            child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: EdgeInsets.all(20),
                color: widget.mainColor,
                child: Text(
                  '${widget.list[index]}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
          );
        });
  }
}
