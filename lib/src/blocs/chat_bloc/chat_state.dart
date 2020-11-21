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
