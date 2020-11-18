import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  static const String id = 'demo_page';
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
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
}
