import 'dart:async';
import 'package:the_chat_app/src/models/size.dart';

class SizeValidatorMixin {
  final sizeValidator =
      StreamTransformer<ContainerSize, ContainerSize>.fromHandlers(
          handleData: (ContainerSize size, EventSink<ContainerSize> sink) {
    if (size.dy < 0) {
      // Going down
      if (size.height > 100) size.updateHeight(Direction.Down);
    } else {
      // Going up
      if (size.height < size.maxHeightConstraint)
        size.updateHeight(Direction.Up);
    }
    sink.add(size);
  });
}
