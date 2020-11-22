import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_chat_app/src/models/chat_model.dart';
import 'package:the_chat_app/src/resources/chat_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final ChatRepository _chatRespository;

  MessageBloc(this._chatRespository) : super(MessageInitial()) {
    _chatRespository.refresh();
    _chatRespository.chatMessages().listen((message) {
      add(NewMessageEvent(message));
    });
  }

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is NewMessageEvent) {
      yield MessageReceived(event.messages);
    }
  }

  @override
  Future<Function> close() {
    _chatRespository.dispose();
    return super.close();
  }
}
