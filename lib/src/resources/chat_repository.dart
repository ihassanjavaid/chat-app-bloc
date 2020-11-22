import 'dart:async';

import 'package:the_chat_app/src/models/chat_model.dart';
import 'package:the_chat_app/src/models/chat_size.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> chatMessages();

  void refresh(ChatMessage message);
  void dispose();
}

class ChatRepositoryMemory extends ChatRepository {
  StreamController<List<ChatMessage>> _streamController = StreamController();

  @override
  Stream<List<ChatMessage>> chatMessages() => _streamController.stream;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void refresh(ChatMessage message) {
    _streamController.add(List()..add(message));
  }
}
