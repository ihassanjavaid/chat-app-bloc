import 'package:flutter/material.dart';
import 'package:the_chat_app/src/ui/widgets/chat_container.dart';
import 'package:intl/intl.dart';

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
                Color(0xffd94e23),
                Color(0xffe78c70),
              ],
              stops: [0.1, 0.4, 0.7]
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
        // getChatContainer(context),
        ChatContainer(),
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
            child: /*Text(
              'THISRTY THURSDAY'
                  '${getCurretTime()}',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'CM Sans Serif',
                  fontSize: 24.0,
                  //fontWeight: FontWeight.bold
              ),
            ),*/
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'THIRSTY THURSDAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'CM Sans Serif',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextSpan(
                    text: '\n'
                  ),
                  TextSpan(
                    text: '${getCurrentTime()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'CM Sans Serif',
                      fontSize: 16.0,
                      //fontWeight: FontWeight.bold
                    ),
                  )
                ]
              ),

            ),
          ),
        ),
      ),
    );
  }
}

String getCurrentTime(){
  DateTime now = DateTime.now();
  String date = DateFormat('MMMM dd').format(now);
  String time = getHourIn12(now);

  return '$date at $time';
}

String getHourIn12(DateTime now){
  if (now.hour <= 12) return '${now.hour}:${getMinute(now)} AM';
  return '${now.hour-12}:${getMinute(now)} PM';
}

String getMinute(DateTime now){
  if (now.minute < 10) return '0${now.minute}';
  return now.minute.toString();
}
