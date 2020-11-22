import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_chat_app/src/models/chat_model.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> chatMessages();

  void refresh();
  void dispose();
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
  void refresh() {
    if (FirebaseFirestore.instance != null) {
      FirebaseFirestore.instance
          .collection('messages')
          .snapshots()
          .listen((messages) {
        _messages.clear();
        messages.docs.forEach((message) {
          final doc = message.data();
          _messages.add(ChatMessage.fromMap(doc));
        });
        _messagesController.add(_messages);
      });
    }
  }
}
/* 
class TipRepositoryFirestore extends TipRepository {

  final _loadedData = StreamController<List<Tip>>();

  final _cache = List<Tip>();

  @override
  void dispose() {
    _loadedData.close();
  }

  @override
  void refresh() {
    if (Firestore.instance != null) {
      Firestore.instance
          .collection('tips')
          .snapshots()
          .listen((techniques) {
        _cache.clear();
        techniques.documents.forEach((tip) {
          final doc = tip.data;
          _cache.add(Tip(doc["tipName"], doc["shortTipText"], doc["fullTipText"]));
        });

        _loadedData.add(_cache);
      });
    }
  }

  @override
  Stream<List<Tip>> tips() => _loadedData.stream;

}
*/
