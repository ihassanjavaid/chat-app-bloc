import 'dart:async';

import 'package:the_chat_app/src/blocs/size_validator.dart';
import 'package:the_chat_app/src/models/size.dart';

class ChatBloc extends Object with SizeValidatorMixin {
  final _resizeController = StreamController<ContainerSize>();

  // Add data
  Function(ContainerSize) get addSize => _resizeController.sink.add;

  // Get data
  Stream<ContainerSize> get size =>
      _resizeController.stream.transform(sizeValidator);

  dispose() {
    _resizeController.close();
  }
}

ChatBloc chatBloc = ChatBloc();
