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
                fontSize: 22.0,
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
      backgroundColor: Colors.blueGrey,
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
                print(drag.primaryDelta);
                setState(() {
                  if (drag.delta.direction > 0) {
                    // Going down
                    if (height > 100) height -= drag.primaryDelta;
                  } else if (drag.delta.direction < 0) {
                    // Going up
                    if (height < topGap) height += -drag.primaryDelta;
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
