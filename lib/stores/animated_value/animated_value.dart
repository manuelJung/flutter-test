import 'package:flutter_app/utils/math.dart';
import 'package:mobx/mobx.dart';

part 'animated_value.g.dart';

// ignore: library_private_types_in_public_api
class AnimatedValue = _AnimatedValue with _$AnimatedValue;

abstract class _AnimatedValue with Store {
  @observable
  double value = 0;

  _AnimatedValue([double init = 0]) {
    value = init;
  }

  double interpolate({required List<num> xs, required List<num> ys}) {
    return Math.interpolate(x: value, xs: xs, ys: ys);
  }

  @action
  void increment() {
    value = value + 1;
  }

  @action
  void setValue(double n) {
    value = n;
  }
}
