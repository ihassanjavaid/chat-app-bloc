part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageReceived extends MessageState {
  final List<ChatMessage> messages;

  MessageReceived(this.messages);
}
