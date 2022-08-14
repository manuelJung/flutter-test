import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../stores/product_list/listing_hit.dart';
import 'animations.dart';

class AnimatedAppBar extends StatelessWidget {
  const AnimatedAppBar({
    Key? key,
  }) : super(key: key);

  static double headerHeight = 80;

  @override
  Widget build(BuildContext context) {
    var scrollPos = context.read<BottomSheetAnimation>();
    var listingHit = context.read<ListingHit>();
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
                opacity: opacity, child: AppBar(title: Text(listingHit.title))),
          ));
    });
  }
}
