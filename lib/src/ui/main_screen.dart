import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_chat_app/src/blocs/chat_bloc/chat_bloc.dart';
import 'package:the_chat_app/src/blocs/message_bloc/message_bloc.dart';
import 'package:the_chat_app/src/resources/utilities/constants.dart';
import 'package:the_chat_app/src/ui/widgets/chat_container.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffc0012a),
                          Color(0xffd94e23),
                          Color(0xffe78c70),
                        ],
                        stops: [
                          0.1,
                          0.4,
                          0.7
                        ]),
                  ),
                  child: getColumn(context),
                ),
              ),
            ),
          ],
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
        Flexible(flex: 0, fit: FlexFit.loose, child: ChatContainer()),
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
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'THIRSTY THURSDAY',
                  style: TextStyle(
                      color: kAshWhiteColor,
                      fontFamily: 'CM Sans Serif',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '\n'),
                TextSpan(
                  text: '${getCurrentTime()}',
                  style: TextStyle(
                    color: kAshWhiteColor,
                    fontFamily: 'CM Sans Serif',
                    fontSize: 16.0,
                    //fontWeight: FontWeight.bold
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
