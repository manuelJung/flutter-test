import 'package:flutter_app/utils/math.dart';
import 'package:mobx/mobx.dart';

part 'animated_value.g.dart';

class AnimatedValue = AnimatedValueBase with _$AnimatedValue;

abstract class AnimatedValueBase with Store {
  @observable
  double value = 0;

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
