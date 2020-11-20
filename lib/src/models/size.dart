class ContainerSize {
  double _width;
  double _height;

  ContainerSize({
    double width = 0,
    double height = 0,
  })  : _width = width,
        _height = height;

  double get width => _width;
  double get height => _height;

  set setHeight(double val) => _height = val;
  set setWidth(double val) => _width = val;

  void updateHeight(double val) => _height += val;
}
