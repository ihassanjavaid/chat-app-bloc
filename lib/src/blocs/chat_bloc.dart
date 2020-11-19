import 'dart:async';

class ChatBloc {
  final _resizeController = StreamController();

  // Add data
  get addSize => _resizeController.sink;

  // Get data
  get size => _resizeController.stream.listen;

  dispose() {
    _resizeController.close();
  }
}
