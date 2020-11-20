import 'dart:async';

import 'package:the_chat_app/src/models/size.dart';

class ChatBloc {
  final _resizeController = StreamController<ContainerSize>();

  // Add data
  Function(ContainerSize) get addSize => _resizeController.sink.add;

  // Get data
  Stream<ContainerSize> get size => _resizeController.stream;

  dispose() {
    _resizeController.close();
  }
}

ChatBloc chatBloc = ChatBloc();
