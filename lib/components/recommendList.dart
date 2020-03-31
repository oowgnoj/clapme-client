import 'package:flutter/material.dart';

class RecommendList extends StatelessWidget {
  // construcort -> super,
  // static 한 것에는 super constructor 필요 없음,

  RecommendList({@required this.list, @required this.mainColor});
  final list;
  final mainColor;

  @override
  Widget build(BuildContext context) {
    print(list);
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              padding: EdgeInsets.all(20),
              color: mainColor,
              child: Text(
                '${list[index]}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ));
        });
  }
}
