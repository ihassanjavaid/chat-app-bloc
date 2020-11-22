import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_chat_app/src/blocs/chat_bloc/chat_bloc.dart';
import 'package:the_chat_app/src/blocs/message_bloc/message_bloc.dart';
import 'package:the_chat_app/src/resources/chat_repository.dart';
import 'package:the_chat_app/src/resources/chat_size_respository.dart';
import 'package:the_chat_app/src/ui/login_screen.dart';
import 'package:the_chat_app/src/ui/main_screen.dart';

class ChatApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChatBloc(UpdateChatSize()),
        ),
        BlocProvider(create: (_) => MessageBloc(ChatRepositoryMemory()))
      ],
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
