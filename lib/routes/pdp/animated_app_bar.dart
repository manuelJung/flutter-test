import 'package:flutter/material.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AnimatedAppBar extends StatelessWidget {
  const AnimatedAppBar({
    Key? key,
    required this.scrollPos,
  }) : super(key: key);

  final AnimatedValue scrollPos;

  static double headerHeight = 80;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      double animated = scrollPos.interpolate(xs: [0, 0.6, 1], ys: [0, 0, 1]);
      double opacity = scrollPos.interpolate(xs: [0, 0.9, 1], ys: [0, 0, 1]);
      return Positioned(
          left: 0,
          right: 0,
          top: -headerHeight + headerHeight * animated,
          height: headerHeight,
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Opacity(
                opacity: opacity, child: AppBar(title: const Text('PDP'))),
          ));
    });
  }
}
