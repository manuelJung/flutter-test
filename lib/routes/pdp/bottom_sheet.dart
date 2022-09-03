import 'package:flutter/material.dart';
import 'package:flutter_app/utils/math.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'animations.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    required this.draggablePercent,
    required this.maxDragablePercent,
    required this.children,
  }) : super(key: key);

  final double draggablePercent;
  final double maxDragablePercent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scrollPos = context.read<BottomSheetAnimation>();
    final controller = context.read<DraggableScrollableController>();

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        scrollPos.setValue(Math.interpolate(
            x: notification.extent, xs: [draggablePercent, 1], ys: [0, 1]));

        return true;
      },
      child: DraggableScrollableSheet(
          initialChildSize: draggablePercent,
          maxChildSize: maxDragablePercent,
          minChildSize: draggablePercent,
          snap: true,
          controller: controller,
          snapSizes: [draggablePercent, maxDragablePercent],
          builder: (BuildContext context, ScrollController scrollController) {
            return Observer(builder: (context) {
              double rounding =
                  scrollPos.interpolate(xs: [0, 0.6, 1], ys: [10, 10, 0]);
              double spreadRadius =
                  scrollPos.interpolate(xs: [0, 0.6, 1], ys: [6, 6, 0]);
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(rounding),
                        topLeft: Radius.circular(rounding),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 18,
                            spreadRadius: spreadRadius,
                            offset: const Offset(0, 1))
                      ]),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListenableProvider(
                      create: (_) => scrollController,
                      child: CustomScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        slivers: children,
                      ),
                    ),
                  ));
            });
          }),
    );
  }
}
