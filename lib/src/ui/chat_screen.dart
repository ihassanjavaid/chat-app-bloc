/*
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = CHATS;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post["lastseen"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      post["message"],
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
                */
/*Image.asset(
                  "assets/images/${post["image"]}",
                  height: double.infinity,
                )*/ /*

              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            */
/*AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: closeTopContainer?0:1,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer?0:categoryHeight,
                  child: categoriesScroller),
            ),*/ /*

            Expanded(
                child: ListView.builder(
                    controller: controller,
                    itemCount: itemsData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      double scale = 1.0;
                      if (topContainer > 0.5) {
                        scale = index + 0.5 - topContainer;
                        if (scale < 0) {
                          scale = 0;
                        } else if (scale > 1) {
                          scale = 1;
                        }
                      }
                      return Opacity(
                        opacity: scale,
                        child: Transform(
                          transform:  Matrix4.identity()..scale(scale,scale),
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              heightFactor: 0.7,
                              alignment: Alignment.topCenter,
                              child: itemsData[index]),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

*/
/*class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    */ /*
*/
/*return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
            ],
          ),
        ),
      ),
    );*/ /*
*/
/*
    return Container();
  }
}*/ /*


const CHATS = [
  {
    "name":"Person 1",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 2",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 3",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 4",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 5",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 6",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 7",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 8",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
  {
    "name":"Person 9",
    "lastseen":"20 hours ago",
    "message":"Hello! This is a sample message",

  },
];*/

import 'package:flutter/material.dart';

import 'chat_thread_screen.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin{
  bool _isChatHidden = true;

  AnimationController _animationController;
  Animation _animation;
  //Tween _tween =

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(-0.4, -8))
        .animate(_animationController);

    /*_animationController.forward().whenComplete(() {
      // put here the stuff you wanna do when animation completed!
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.deepPurple],
            stops: [0.2, 0.6],
          ),
        ),
        child: Stack(
          //mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: _isChatHidden ?
              Alignment.center : Alignment.topLeft,
              child: SlideTransition(
                position: _animation,
                child: Text(
                  'The Cabinet',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTapDown: (details){
                  setState(() {
                    //_isChatHidden = !_isChatHidden;
                    _animationController.forward().whenComplete(() {
                      _animationController.reverse();
                    });
                  });
                },
                child: ChatThread()
            ),
          ],
        ),
      ),
    );
  }
}

