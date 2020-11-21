import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_chat_app/src/blocs/chat_bloc/chat_bloc.dart';
import 'package:the_chat_app/src/resources/chat_size_repository.dart';
import 'package:the_chat_app/src/ui/login_screen.dart';
import 'package:the_chat_app/src/ui/main_screen.dart';

class ChatApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    return BlocProvider(
      create: (context) => ChatBloc(UpdateChatSize()),
      child: MaterialApp(
        title: 'The Chat App',
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (_) => LoginScreen(),
          MainScreen.id: (_) => MainScreen(),
        },
      ),
    );
  }
}
