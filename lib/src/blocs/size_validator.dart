import 'dart:async';

class SizeValidatorMixin {
  final sizeValidator =
      StreamTransformer.fromHandlers(handleData: (double deltaSize, sink) {
    if (deltaSize > 0) {
      // Going down

    } else {
      // Going down

    }
  });
}
