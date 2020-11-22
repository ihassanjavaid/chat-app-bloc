import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_chat_app/src/blocs/chat_bloc/chat_bloc.dart';
import 'package:the_chat_app/src/blocs/message_bloc/message_bloc.dart';
import 'package:the_chat_app/src/models/chat_model.dart';
import 'package:the_chat_app/src/models/chat_size.dart';
import 'package:the_chat_app/src/resources/services/auth_service.dart';
import 'package:the_chat_app/src/resources/services/firestore_service.dart';
import 'package:the_chat_app/src/resources/utilities/constants.dart';

final TextEditingController controller = TextEditingController();

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
          if (size == null) {
            size = ChatSize(
              height: MediaQuery.of(context).size.height * 0.84,
              width: MediaQuery.of(context).size.width,
              screenMaxHeight: MediaQuery.of(context).size.height,
              screenMaxWidth: MediaQuery.of(context).size.width,
              maxHeightConstraint: 0.85,
            );
          }
          if (state is ChatMoving) {
            size = state.size;
          } else if (state is ChatCollapsed) {
            return getCollapsedChat();
          }
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
              child: getWidgets(context),
            ),
          );
        },
      ),
    );
  }

  Widget getWidgets(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getChatHeader(),
        getChatSpace(),
        getChatControl(context),
      ],
    );
  }

  Widget getChatHeader({bool collapsed = false}) {
    return Column(
      children: [
        Container(
          height: 15.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24.0),
              ),
              color: kLightGreyColor),
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
            backgroundColor: kLightGreyColor,
            elevation: 0,
            leading: collapsed
                ? Container()
                : FlatButton(
                    onPressed: () {
                      // TODO: Add functionality
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
                      'Group\tA',
                      style: TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'CM Sans Serif'),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'You, Elvin, Arrow',
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
                width: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getChatSpace() {
    return Flexible(
      child: BlocConsumer<MessageBloc, MessageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is MessageInitial) {
            return CircularProgressIndicator();
          } else if (state is MessageReceived) {
            return ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (_, index) {
                final ChatMessage chatMessage = state.messages[index];
                //return Text(chatMessage.message);
                double bubbleSpace = MediaQuery.of(context).size.width / 2.1;
                return Column(
                  crossAxisAlignment: chatMessage.sender == 'ME'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Bubble(
                      margin: chatMessage.sender == 'ME'
                          ? BubbleEdges.only(
                              top: 10, right: 5, left: bubbleSpace)
                          : BubbleEdges.only(
                              top: 10, right: bubbleSpace, left: 5),
                      nip: chatMessage.sender == 'ME'
                          ? BubbleNip.rightBottom
                          : BubbleNip.leftBottom,
                      elevation: 1,
                      color: chatMessage.sender == 'ME'
                          ? kOrangeColor
                          : kLightGreyColor,
                      child: Text(
                        chatMessage.message,
                        style: TextStyle(fontFamily: 'CM Sans Serif'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 2),
                      child: Text(
                        chatMessage.sender == 'ME'
                            ? ''
                            : '${chatMessage.sender}',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontFamily: 'CM Sans Serif',
                            color: kLightGreyColor),
                      ),
                    )
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget getChatControl(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(color: kLightGreyColor),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: kRedColor,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Icon(
                      Icons.photo,
                      size: 30,
                      color: kRedColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: (MediaQuery.of(context).size.width) / 1.8,
                      height: 38,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: TextField(
                          controller: controller,
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
                  /*SizedBox(
                    width: 10,
                  ),*/
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: FlatButton.icon(
                        onPressed: () async {
                          try {
                            // ignore: close_sinks
                            final messageBloc = context.read<MessageBloc>();
                            final sender =
                                await FirestoreService().getUserData();
                            final message = controller.text;
                            final timestamp = DateTime.now();
                            messageBloc.add(
                              SendMessageEvent(
                                ChatMessage(
                                    message, sender.firstName, timestamp),
                              ),
                            );
                            controller.text = '';
                          } catch (_) {}
                        },
                        icon: Icon(
                          Icons.send,
                          size: 30,
                          color: kRedColor,
                        ),
                        label: Text('Send'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCollapsedChat() {
    return getChatHeader(collapsed: true);
  }
}
