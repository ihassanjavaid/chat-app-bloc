class ContainerSize {
  double _width;
  double _height;
  double _dy;

  ContainerSize({
    double width = 0,
    double height = 0,
    double dy = 0,
  })  : _width = width,
        _height = height,
        _dy = dy;

  double get width => _width;
  double get height => _height;

  set setHeight(double val) => _height = val;
  set setWidth(double val) => _width = val;
  set setDeltaY(double val) => _dy = val;

  void updateHeight(double val) => _height += val;
}
