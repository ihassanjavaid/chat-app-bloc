import 'package:the_chat_app/src/ui/chat_screen.dart';
import 'package:flutter/material.dart';



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
      debugShowCheckedModeBanner: false,
      title: 'The Chat App',
      home: ChatScreen(),
    );
  }
}
