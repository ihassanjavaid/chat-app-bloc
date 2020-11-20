import 'dart:async';

class ChatBloc {
  final _resizeController = StreamController();

  // Add data
  Function(double) get addSize => _resizeController.sink.add;

  // Get data
  get size => _resizeController.stream.listen;

  dispose() {
    _resizeController.close();
  }
}
