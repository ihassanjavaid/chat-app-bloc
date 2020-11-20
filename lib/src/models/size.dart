enum Direction {
  Up,
  Down,
  Left,
  Right,
}

/// The property [maxHeightConstraint] should be between [0] and [1].
///
class ContainerSize {
  double _width;
  double _height;
  double _dy;
  double _screenMaxHeight;
  double _screenMaxWidth;
  double _maxHeightConstraint;

  ContainerSize({
    double width = 0,
    double height = 0,
    double dy = 0,
    double screenMaxHeight = 0,
    double screenMaxWidth = 0,
    double maxHeightConstraint = 0,
  })  : _width = width,
        _height = height,
        _dy = dy,
        _screenMaxHeight = screenMaxHeight,
        _screenMaxWidth = screenMaxWidth,
        _maxHeightConstraint = maxHeightConstraint * screenMaxWidth,
        assert(maxHeightConstraint >= 0 && maxHeightConstraint <= 1);

  double get width => _width;
  double get height => _height;
  double get dy => _dy;
  double get screenMaxHeight => _screenMaxHeight;
  double get screenMaxWidth => _screenMaxWidth;
  double get maxHeightConstraint => _maxHeightConstraint;

  set setHeight(double val) => _height = val;
  set setWidth(double val) => _width = val;
  set setDy(double val) => _dy = -val;

  /// Adds or subtracts height value based on the change in height induced by
  /// the [DragUpdateDetails] parameter of the [onVerticalDrag] callback
  /// for the [GestureDetector].
  ///
  void updateHeight(Direction direction) {
    switch (direction) {
      case Direction.Down:
        print('Going down...');
        if (_height + _dy < 100)
          _height = 100;
        else
          _height += _dy;
        break;

      case Direction.Up:
        print('Going up...');
        if (_height + _dy > maxHeightConstraint)
          _height = maxHeightConstraint;
        else
          _height += _dy;
        break;
      default:
    }
    direction == Direction.Down ? _height += -_dy : _height += _dy;
  }
}
