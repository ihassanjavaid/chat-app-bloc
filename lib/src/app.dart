import 'package:flutter/material.dart';
import 'package:the_chat_app/src/ui/login_screen.dart';
import 'package:the_chat_app/src/ui/main_screen.dart';

class ChatApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    return MaterialApp(
      title: 'The Chat App',
      debugShowCheckedModeBanner: false,
      initialRoute: MainScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
