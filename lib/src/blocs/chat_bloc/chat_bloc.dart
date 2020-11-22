import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_chat_app/src/models/chat_size.dart';
import 'package:the_chat_app/src/resources/chat_size_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatSizeRepository _sizeRepository;

  ChatBloc(this._sizeRepository) : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is ChatSizeUpdate) {
      // Acquire the size from the event
      ChatSize size = event.size;

      // Pass on the event data to the repository for processing
      _sizeRepository.updateSize(size);

      if (size.height > 100) {
        // Throw the updated size unto the stream
        yield ChatMoving(size);
        yield ChatMoved();
      } else {
        yield ChatCollapsed();
      }
    }
  }
}
