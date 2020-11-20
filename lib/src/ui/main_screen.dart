import 'package:flutter/material.dart';
import 'package:the_chat_app/src/blocs/chat_bloc.dart';
import 'package:the_chat_app/src/models/size.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    double threshold = MediaQuery.of(context).size.height * 0.18;
    double topGap = MediaQuery.of(context).size.height * 0.85;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: StreamBuilder(
          stream: chatBloc.size,
          builder: (context, snapshot) {
            ContainerSize size;
            if (!snapshot.hasData) {
              // First run
              size = ContainerSize(
                height: MediaQuery.of(context).size.height * 0.84,
                width: MediaQuery.of(context).size.width,
              );
            } else {
              size = snapshot.data;
            }
            return Column(
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
                    // Going down
                    if (drag.delta.direction > 0) {
                      if (size.height > 100)
                        size.updateHeight(-drag.primaryDelta);
                    } else if (drag.delta.direction < 0) {
                      // Going up
                      if (size.height < topGap)
                        size.updateHeight(-drag.primaryDelta);
                    }

                    chatBloc.addSize(size);
                  },
                  child: Align(
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
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
