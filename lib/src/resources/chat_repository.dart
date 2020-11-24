import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_chat_app/src/models/chat_model.dart';
import 'package:the_chat_app/src/resources/services/firestore_service.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> chatMessages();

  void refresh();
  void dispose();
  void sendMessage(ChatMessage message);
}

class ChatRepositoryMemory extends ChatRepository {
  StreamController<List<ChatMessage>> _messagesController =
      StreamController<List<ChatMessage>>();
  List<ChatMessage> _messages = List<ChatMessage>();

  @override
  Stream<List<ChatMessage>> chatMessages() => _messagesController.stream;

  @override
  void dispose() {
    _messagesController.close();
  }

  @override
  void refresh() async {
    // Get current user
    final user = await FirestoreService().getUserData();
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance
          .collection('messages')
          .orderBy('timestamp')
          .snapshots()
          .listen((messages) {
        _messages.clear();
        messages.docs.forEach((message) {
          final doc = message.data();
          _messages.add(ChatMessage.fromMap(doc));
        });

        final myMessages =
            _messages.where((message) => message.sender == user.firstName);
        myMessages.forEach((message) {
          message.isMe = true;
        });
        _messagesController.add(_messages);
      });
    }
  }

  @override
  void sendMessage(ChatMessage message) {
    print('Sending message');
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance.collection('messages').add(message.toMap());
    }
    print('Message sent');
  }
}
