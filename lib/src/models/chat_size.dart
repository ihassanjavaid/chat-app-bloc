/// The property [maxHeightConstraint] should be between [0] and [1].
///
class ChatSize {
  double _width;
  double _height;
  double _dy;
  double _screenMaxHeight;
  double _screenMaxWidth;
  double _maxHeightConstraint;

  ChatSize({
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
        _maxHeightConstraint = maxHeightConstraint * screenMaxHeight,
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

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChatSize &&
        o._width == _width &&
        o._height == _height &&
        o._dy == _dy &&
        o._screenMaxHeight == _screenMaxHeight &&
        o._screenMaxWidth == _screenMaxWidth &&
        o._maxHeightConstraint == _maxHeightConstraint;
  }

  @override
  int get hashCode {
    return _width.hashCode ^
        _height.hashCode ^
        _dy.hashCode ^
        _screenMaxHeight.hashCode ^
        _screenMaxWidth.hashCode ^
        _maxHeightConstraint.hashCode;
  }
}
