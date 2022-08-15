import 'package:flutter/material.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:flutter_app/stores/impression/impressions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../utils/math.dart';

class ImpressionPage extends StatelessWidget {
  final ImpressionsStore store;
  final int index;
  const ImpressionPage({super.key, required this.store, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Provider(
        create: (_) => AnimatedValue(0),
        child: Builder(builder: (context) {
          final scrollPos = context.read<AnimatedValue>();
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              final pixels = notification.metrics.pixels;
              if (pixels < 0) {
                scrollPos.setValue(0);
              } else {
                var interpolated = Math.interpolate(
                  x: notification.metrics.pixels,
                  xs: [0, size.width],
                  ys: [0, 1],
                );
                if (interpolated < 0) interpolated = 0;
                if (interpolated > 1) interpolated = 1;
                scrollPos.setValue(interpolated);
              }

              return true;
            },
            child: CustomScrollView(slivers: [
              SliverAppBar(
                title: Observer(builder: (context) {
                  return Text(
                    'Title',
                    style: TextStyle(
                      color: Colors.black.withOpacity(scrollPos.interpolate(
                        xs: [0, 0.7, 1],
                        ys: [0, 0, 1],
                      )),
                    ),
                  );
                }),
                expandedHeight: size.width,
                flexibleSpace: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.network(
                      store.items[index].img,
                      fit: BoxFit.cover,
                    )),
                    Positioned.fill(child: Observer(builder: (context) {
                      return Container(
                        color: Colors.amber.withOpacity(scrollPos.interpolate(
                          xs: [0, 0.7, 1],
                          ys: [0, 0, 1],
                        )),
                      );
                    }))
                  ],
                ),
                pinned: true,
              ),
              const SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Dargestellte Artikel:',
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  return Container(
                    color: Colors.grey,
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 10),
                  );
                }),
                childCount: 10,
              ))
            ]),
          );
        }),
      ),
    );
  }
}
