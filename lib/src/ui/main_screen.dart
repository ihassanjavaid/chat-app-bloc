import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_chat_app/src/blocs/chat_bloc/chat_bloc.dart';
import 'package:the_chat_app/src/models/chat_size.dart';


class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffc0012a),
                Color(0xffe78c70),
              ],
            ),
          ),
          child: getColumn(context),
        ),
      ),
    );
  }

  Widget getColumn(BuildContext context) {
    return Column(
      children: [
        // Text Container
        getTextContainer(context),
        SizedBox(height: 12.0),
        // Chat container
        getChatContainer(context),
      ],
    );
  }

  Widget getTextContainer(BuildContext context) {
    double threshold = MediaQuery.of(context).size.height * 0.18;

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          constraints: constraints,
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: AnimatedAlign(
            duration: Duration(milliseconds: 750),
            alignment: constraints.biggest.height >= threshold
                ? Alignment.center
                : Alignment.centerLeft,
            child: Text(
              'Cabinet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getChatContainer(BuildContext context) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*Container(
                    height: 10,
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 18.0,
                        left: 120,
                        right: 120,
                      ),
                      child: Divider(
                        color: Colors.black54,
                        thickness: 5,
                      ),
                    ),
                  ),*/
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
                                /*SizedBox(
                                width: 15,
                              ),*/
                                /*Icon(
                                Icons.keyboard_voice,
                                size: 30,
                                color: kRedColor,
                              ),*/
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            //width: (MediaQuery.of(context).size.width - 40) / 2,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Container(
                                    width:
                                    (MediaQuery.of(context).size.width - 10) /
                                        2,
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
              ),
            ),
          );
        },
      ),
    );
  }
}

/* class _MainScreenState extends State<MainScreen> {
  bool firstLaunch = true;
  double height = 1;
  double width = 1;
  double topGap;

  double getHeight(int containerNumber) {
    if (firstLaunch) {
      height = MediaQuery.of(context).size.height * 0.84;
    }

    firstLaunch = false;
    return height;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    double threshold = MediaQuery.of(context).size.height * 0.18;
    topGap = MediaQuery.of(context).size.height * 0.85;
    return Scaffold(
      backgroundColor: kRedColorGrey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => Container(
                  constraints: constraints,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: AnimatedAlign(
                    duration: Duration(milliseconds: 750),
                    alignment: constraints.biggest.height >= threshold
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: Text(
                      'Cabinet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            GestureDetector(
              onVerticalDragUpdate: (drag) {
                print(drag.kRedColorDelta);
                setState(() {
                  if (drag.delta.direction > 0) {
                    // Going down
                    if (height > 100) height -= drag.kRedColorDelta;
                  } else if (drag.delta.direction < 0) {
                    // Going up
                    if (height < topGap) height += -drag.kRedColorDelta;
                  }
                });
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  height: getHeight(2),
                  width: this.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} */
