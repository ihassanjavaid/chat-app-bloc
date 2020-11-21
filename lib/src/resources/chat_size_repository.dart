import 'package:the_chat_app/src/models/chat_size.dart';

abstract class ChatSizeRepository {
  ChatSize updateSize(ChatSize size);
}

class UpdateChatSize extends ChatSizeRepository {
  @override
  ChatSize updateSize(ChatSize size) {
    if (size.dy < 0) {
      // Going down
      if (size.height > 100) {
        if (size.height + size.dy < 100)
          size.setHeight = 100;
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
