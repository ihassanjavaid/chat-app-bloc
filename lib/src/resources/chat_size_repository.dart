import 'package:the_chat_app/src/models/chat_size.dart';

abstract class ChatRepository {
  ChatSize updateSize(ChatSize size);
}

class UpdateChatSize extends ChatRepository {
  @override
  ChatSize updateSize(ChatSize size) {
    final double kChatMinHeight = 100;
    if (size.dy < 0) {
      // Going down
      if (size.height > kChatMinHeight) {
        if (size.height + size.dy < kChatMinHeight)
          size.setHeight = kChatMinHeight;
        else
          size.setHeight = size.height + size.dy;
      }
    } else {
      // Going up
      if (size.height < size.maxHeightConstraint) {
        if ((size.height + size.dy) > size.maxHeightConstraint)
          size.setHeight = size.maxHeightConstraint - 1;
        else
          size.setHeight = size.height + size.dy;
      }
    }
    return size;
  }
}
