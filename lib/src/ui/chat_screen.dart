import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_chat_app/src/resources/utilities/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "ChatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //@override
  /*Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: GestureDetector(
        onVerticalDragStart: (DragStartDetails details){
          showChat(details);
          showBottomSheet(
              context: context,
              builder: (context) => Container(
                color: Colors.red,
              ));
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      return GestureDetector(
        onVerticalDragStart: (DragStartDetails details) {
          showChat(details);
          showBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(8.0), child: Container()),
                    ),
                    Container(
                      decoration: kMessageContainerDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              //controller: messageTextController,
                              onChanged: (value) {
                                //_message = value;
                              },
                              decoration: kMessageTextFieldDecoration,
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              /*final currentUser = await Auth().currentUser;
                              // Create the message
                              Message newMessage = Message(
                                messageSender: currentUser.email,
                                messageReceiver: this.user.email,
                                messageText: _message,
                                timestamp: DateTime.now().millisecondsSinceEpoch,
                              );
                              await FirestoreService().sendMessage(newMessage);
                              messageTextController.clear();*/
                            },
                            child:
                                /*Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    )*/
                                Icon(
                              Icons.send,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pinkAccent,
                  Colors.pink,
                  Colors.purpleAccent,
                  Colors.purple
                ],
                stops: [
                  0.1,
                  0.2,
                  0.7,
                  0.9
                ]),
          ),
        ),
      );
    }));
  }

  void showChat(DragStartDetails details) {
    // TODO check if dragging up
  }
}
