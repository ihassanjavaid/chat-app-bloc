import 'package:flutter/material.dart';
import 'package:the_chat_app/src/ui/widgets/chat_container.dart';

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
            child: Text(
              'Cabinet',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
