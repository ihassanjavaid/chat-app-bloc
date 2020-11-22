part of 'chat_bloc.dart';

@immutable
abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {}

class ChatMoving extends ChatState {
  final ChatSize size;

  ChatMoving(this.size);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChatMoving && o.size == size;
  }

  @override
  int get hashCode => size.hashCode;
}

class ChatMoved extends ChatState {}

class ChatCollapsed extends ChatState {}

class ChatRecievedState extends ChatState {
  final ChatMessage chatMessage;

  ChatRecievedState(this.chatMessage);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChatRecieved && o.chatMessage == chatMessage;
  }

  @override
  int get hashCode => chatMessage.hashCode;
}

class ChatSentState extends ChatState {}
