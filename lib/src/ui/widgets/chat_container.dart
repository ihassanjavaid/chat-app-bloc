import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_chat_app/src/blocs/chat_bloc/chat_bloc.dart';
import 'package:the_chat_app/src/models/chat_size.dart';
import 'package:the_chat_app/src/resources/utilities/constants.dart';

class ChatContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatSize size;
    return GestureDetector(
      onVerticalDragUpdate: (drag) {
        // ignore: close_sinks
        final sizeBloc = context.read<ChatBloc>();
        size.setDy = drag.primaryDelta;
        sizeBloc.add(ChatSizeUpdate(size));
      },
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (_, state) {
          if (state is ChatInitial) {
            size = ChatSize(
              height: MediaQuery.of(context).size.height * 0.84,
              width: MediaQuery.of(context).size.width,
              screenMaxHeight: MediaQuery.of(context).size.height,
              screenMaxWidth: MediaQuery.of(context).size.width,
              maxHeightConstraint: 0.85,
            );
          } else if (state is ChatMoving) {
            size = state.size;
          } else if (state is ChatCollapsed) {}
          return Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: getColumn(context),
            ),
          );
        },
      ),
    );
  }

  Widget getColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 15,
          color: Colors.grey.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 135,
              right: 135,
            ),
            child: Divider(
              color: Colors.black54,
              thickness: 5,
            ),
          ),
        ),
        PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            elevation: 0,
            leading: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: kRedColor,
                )),
            title: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'The\tCabinet',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Talha, Ali, Osama',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4), fontSize: 14),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              Icon(
                Icons.phone,
                color: kRedColor,
                size: 32,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.videocam_sharp,
                color: kRedColor,
                size: 35,
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white38)),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4)),
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  //width: (MediaQuery.of(context).size.width - 60) / 2,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_circle,
                        size: 30,
                        color: kRedColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: kRedColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.photo,
                        size: 30,
                        color: kRedColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 10) / 2,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: TextField(
                              cursorColor: Colors.black,
                              //controller: _sendMessageController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Text Message',
                                  suffixIcon: Icon(
                                    Icons.face,
                                    color: kRedColor,
                                    size: 28,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.thumb_up,
                        size: 30,
                        color: kRedColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getCollapsedChat() {
    return Column(
      children: [
        Container(
          height: 15,
          color: Colors.grey.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 135,
              right: 135,
            ),
            child: Divider(
              color: Colors.black54,
              thickness: 5,
            ),
          ),
        ),
        PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            elevation: 0,
            title: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'The\tCabinet',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Talha, Ali, Osama',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4), fontSize: 14),
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              Icon(
                Icons.phone,
                color: kRedColor,
                size: 32,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.videocam_sharp,
                color: kRedColor,
                size: 35,
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white38)),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
