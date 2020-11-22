import 'dart:convert';

class ChatMessage {
  final String message;
  final String sender;
  final DateTime timestamp;

  ChatMessage(this.message, this.sender, this.timestamp);

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sender': sender,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChatMessage(
      map['message'],
      map['sender'],
      DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));
}
