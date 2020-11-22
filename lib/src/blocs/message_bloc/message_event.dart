part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class NewMessageEvent extends MessageEvent {
  final List<ChatMessage> messages;

  NewMessageEvent(this.messages);
}
