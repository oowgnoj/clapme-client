//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:web_socket_channel/web_socket_channel.dart';
//
//
//class Comment extends StatefulWidget {
//  final WebSocketChannel channel;
//
//  Comment({Key key, @required this.channel})
//      : super(key: key);
//
//  @override
//  _CommentState createState() => _CommentState();
//}
//
//class _CommentState extends State<Comment> {
//  TextEditingController _controller = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('매일 만보걷기'),
//      ),
//      body: Padding(
//        padding: const EdgeInsets.all(20.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Form(
//              child: TextFormField(
//                controller: _controller,
//                decoration: InputDecoration(labelText: '댓글 쓰기'),
//              ),
//            ),
//            StreamBuilder(
//              stream: widget.channel.stream,
//              builder: (context, snapshot) {
//                return Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 24.0),
//                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
//                );
//              },
//            )
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _sendMessage,
//        tooltip: 'Send message',
//        child: Icon(Icons.send),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//
//  void _sendMessage() {
//    print(_controller.text);
//    if (_controller.text.isNotEmpty) {
//      widget.channel.sink.add(_controller.text);
//    }
//  }
//
//  @override
//  void dispose() {
//    print('dispose');
//    widget.channel.sink.close();
//    super.dispose();
//  }
//}



//import 'package:flutter/material.dart';
//import 'package:flutter_socket_io/flutter_socket_io.dart';
//import 'package:flutter_socket_io/socket_io_manager.dart';
//
//class Comment extends StatefulWidget {
//  @override
//  _CommentState createState() => new _CommentState();
//}
//
//class _CommentState extends State<Comment> {
//  int _counter = 0;
//  var mTextMessageController = new TextEditingController();
//  SocketIO socketIO;
//  SocketIO socketIO02;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  _connectSocket01() {
//    socketIO = SocketIOManager().createSocketIO("http://15.164.96.238:5000", "/goal", query: "Goal_id=hello", socketStatusCallback: _socketStatus);
//
//    //call init socket before doing anything
//    socketIO.init();
//
//    //subscribe event
//    socketIO.subscribe("socket_info", _onSocketInfo);
//
//    //connect socket
//    socketIO.connect();
//  }
//
//  _onSocketInfo(dynamic data) {
//    print("Socket info: " + data);
//  }
//
//  _socketStatus(dynamic data) {
//    print("Socket status: " + data);
//  }
//
//  _subscribes() {
//    if (socketIO != null) {
//      socketIO.subscribe("chat_direct", _onReceiveComment);
//    }
//  }
//
//  _unSubscribes() {
//    if (socketIO != null) {
//      socketIO.unSubscribe("chat_direct", _onReceiveComment);
//    }
//  }
//
//  _reconnectSocket() {
//    if (socketIO == null) {
//      _connectSocket01();
//    } else {
//      socketIO.connect();
//    }
//  }
//
//  _disconnectSocket() {
//    if (socketIO != null) {
//      socketIO.disconnect();
//    }
//  }
//
//  _destroySocket() {
//    if (socketIO != null) {
//      SocketIOManager().destroySocket(socketIO);
//    }
//  }
//
//  void _sendChatMessage(String msg) async {
//    if (socketIO != null) {
//      String jsonData =
//          '{"message":{"type":"Text","content": ${(msg != null && msg.isNotEmpty) ? '"${msg}"' : '"Hello SOCKET :))"'},,"Goal_id":2, "goal_id": 11}';
//      socketIO.sendMessage("comment", jsonData, _onReceiveComment);
//    }
//  }
//
//  void socketInfo(dynamic message) {
//    print("Socket Info: " + message);
//  }
//
//  void _onReceiveComment(dynamic message) {
//    print("Message from someone: " + message);
//  }
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  void _showToast() {
//    _sendChatMessage(mTextMessageController.text);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new Center(
//        child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            new RaisedButton(
//              child:
//              const Text('CONNECT  SOCKET 01', style: TextStyle(color: Colors.white)),
//              color: Theme.of(context).accentColor,
//              elevation: 0.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                _connectSocket01();
//                _sendChatMessage(mTextMessageController.text);
//              },
//            ),
//            new RaisedButton(
//              child: const Text('SEND MESSAGE', style: TextStyle(color: Colors.white)),
//              color: Theme.of(context).accentColor,
//              elevation: 0.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                _showToast();
//                _sendChatMessage(mTextMessageController.text);
//              },
//            ),
//            new RaisedButton(
//              child: const Text('SUBSCRIBES',
//                  style: TextStyle(color: Colors.white)),
//              color: Theme.of(context).accentColor,
//              elevation: 0.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                _subscribes();
//                _sendChatMessage(mTextMessageController.text);
//              },
//            ),
//            new RaisedButton(
//              child: const Text('UNSUBSCRIBES',
//                  style: TextStyle(color: Colors.white)),
//              color: Theme.of(context).accentColor,
//              elevation: 0.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                _unSubscribes();
//                _sendChatMessage(mTextMessageController.text);
//              },
//            ),
//            new RaisedButton(
//              child: const Text('RECONNECT',
//                  style: TextStyle(color: Colors.white)),
//              color: Theme.of(context).accentColor,
//              elevation: 0.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                _reconnectSocket();
//                _sendChatMessage(mTextMessageController.text);
//              },
//            ),
//            new RaisedButton(
//              child: const Text('DISCONNECT',
//                  style: TextStyle(color: Colors.white)),
//              color: Theme.of(context).accentColor,
//              elevation: 0.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                _disconnectSocket();
//                _sendChatMessage(mTextMessageController.text);
//              },
//            ),
//            new RaisedButton(
//              child:
//              const Text('DESTROY', style: TextStyle(color: Colors.white)),
//              color: Theme.of(context).accentColor,
//              elevation: 0.0,
//              splashColor: Colors.blueGrey,
//              onPressed: () {
//                _destroySocket();
//                _sendChatMessage(mTextMessageController.text);
//              },
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}


import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/s_goal_model.dart';
import '../models/s_message_model.dart';
import '../models/s_thread_model.dart';

class Comment extends StatefulWidget {
  final Goal friend;
  Comment(this.friend);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController textEditingController = TextEditingController();

  Widget buildSingleMessage(Message message) {
    return Container(
      alignment: message.senderID == widget.friend.goalId
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(message.text),
    );
  }

  Widget buildChatList() {
    return ScopedModelDescendant<ThreadModel>(
      builder: (context, child, model) {
        List<Message> messages =
        model.getMessagesForGoalId(widget.friend.goalId);

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return buildSingleMessage(messages[index]);
            },
          ),
        );
      },
    );
  }

  Widget buildChatArea() {
    return ScopedModelDescendant<ThreadModel>(
      builder: (context, child, model) {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: textEditingController,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                onPressed: () {
                  model.sendMessage(
                      textEditingController.text, widget.friend.goalId);
                  textEditingController.text = '';
                },
                elevation: 0,
                child: Icon(Icons.send),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend.title),
      ),
      body: ListView(
        children: <Widget>[
          buildChatList(),
          buildChatArea(),
        ],
      ),
    );
  }
}