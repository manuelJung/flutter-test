import 'package:flutter/material.dart';
import 'package:flutter_app/stores/animated_value.dart';
import 'package:flutter_app/utils/math.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    required this.scrollPos,
    required this.draggablePercent,
    required this.headerPercent,
    required this.maxDragablePercent,
    required this.children,
  }) : super(key: key);

  final AnimatedValue scrollPos;
  final double draggablePercent;
  final double headerPercent;
  final double maxDragablePercent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        scrollPos.setValue(Math.interpolate(
            x: notification.extent,
            xs: [draggablePercent, 1 - headerPercent],
            ys: [0, 1]));

        return true;
      },
      child: DraggableScrollableSheet(
          initialChildSize: draggablePercent,
          maxChildSize: maxDragablePercent - headerPercent,
          minChildSize: draggablePercent,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
                color: Colors.grey[200],
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    children: children,
                  ),
                ));
          }),
    );
  }
}
