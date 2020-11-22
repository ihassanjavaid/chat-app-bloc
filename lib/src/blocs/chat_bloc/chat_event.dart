part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class ChatSizeUpdate extends ChatEvent {
  final ChatSize size;

  ChatSizeUpdate(this.size);
}
