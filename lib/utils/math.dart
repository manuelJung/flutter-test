class Math {
  static double interpolate(
      {required num x,
      required List<num> xs,
      required List<num> ys,
      bool log = false}) {
    assert(xs.length == ys.length, 'xs and ys need to be the same size');
    num x1 = -1;
    num x2 = -1;
    num y1 = -1;
    num y2 = -1;

    for (int i = 0; i < xs.length; i++) {
      if (i + 1 == xs.length || x < xs[i]) {
        x1 = xs[i - 1];
        x2 = xs[i];
        y1 = ys[i - 1];
        y2 = ys[i];
        break;
      }
    }

    if (log) {
      print('x: $x xs: [$x1, $x2] ys: [$y1, $y2]');
    }

    // // https://sciencing.com/interpolate-numbers-8680223.html
    return y1 + ((x - x1) / (x2 - x1)) * (y2 - y1);
  }
}
