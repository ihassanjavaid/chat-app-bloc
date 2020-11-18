import 'package:flutter/material.dart';
import 'package:the_chat_app/src/resources/utilities/constants.dart';

// ignore: must_be_immutable
class ChatThread extends StatelessWidget {
  //TextEditingController _sendMessageController = new TextEditingController();
  /*String titleText;
  Color containerColor;*/

  ChatThread({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //showBottomSheet(context: context,builder: (buildContext){});
    return DraggableScrollableSheet(
      minChildSize: 0.1,
      initialChildSize: 0.1,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 5,
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
                ),
                PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: AppBar(
                    backgroundColor: grey.withOpacity(0.2),
                    elevation: 0,
                    leading: FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: primary,
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
                                  color: black),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Talha, Ali, Osama',
                              style: TextStyle(
                                  color: black.withOpacity(0.4), fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                    actions: <Widget>[
                      Icon(
                        Icons.phone,
                        color: primary,
                        size: 32,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.videocam_sharp,
                        color: primary,
                        size: 35,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                            color: online,
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
                  decoration: BoxDecoration(color: grey.withOpacity(0.4)),
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
                                color: primary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: primary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.photo,
                                size: 30,
                                color: primary,
                              ),
                              /*SizedBox(
                                width: 15,
                              ),*/
                              /*Icon(
                                Icons.keyboard_voice,
                                size: 30,
                                color: primary,
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
                                      color: grey,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: TextField(
                                      cursorColor: black,
                                      //controller: _sendMessageController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Text Message',
                                          suffixIcon: Icon(
                                            Icons.face,
                                            color: primary,
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
                                color: primary,
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
    );
  }
}
