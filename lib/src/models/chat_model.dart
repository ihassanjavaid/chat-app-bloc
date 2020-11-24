import 'dart:convert';

class ChatMessage {
  final String message;
  final String sender;
  bool isMe;
  final DateTime timestamp;

  ChatMessage(
    this.message,
    this.sender,
    this.timestamp, [
    this.isMe,
  ]);

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sender': sender,
      'isMe': isMe,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChatMessage(
      map['message'],
      map['sender'],
      DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      map['isMe'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));
}
