part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatSizeUpdate extends ChatEvent {
  final ChatSize size;

  ChatSizeUpdate(this.size);
}

class ChatSent extends ChatEvent {
  final ChatMessage chatMessage;

  ChatSent(this.chatMessage);
}

class ChatRecieved extends ChatEvent {
  final ChatMessage chatMessage;

  ChatRecieved(this.chatMessage);
}
