import 'package:flutter/material.dart';
import 'package:the_chat_app/src/ui/chat_screen.dart';
import 'package:the_chat_app/src/ui/login_screen.dart';
import 'package:the_chat_app/src/ui/main_screen.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Chat App',
      debugShowCheckedModeBanner: false,
      initialRoute: ChatScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        //MainScreen.id: (context) => MainScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
