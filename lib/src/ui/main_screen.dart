/*
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Chats",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          body: Card(
            elevation: 10,
            child: Container(
              child: Row(
                children: [
                  Container(
                    height: 70.0,
                    width: 70.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                      child: CircleAvatar(
                        child: Text(
                          "M",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AutoSizeText(
                              "Muhammad Talha Bin Mansoor",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 22,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text("Message........"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
*/
