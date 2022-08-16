import 'package:flutter/material.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:flutter_app/stores/impression/impressions.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_app/widgets/listing_teaser.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../utils/math.dart';
import '../../widgets/product_widget.dart';

class ImpressionPage extends StatelessWidget {
  final ImpressionsStore store;
  final int index;
  const ImpressionPage({super.key, required this.store, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: MultiProvider(
        providers: [
          Provider(create: (_) => AnimatedValue(0)),
          Provider(
            create: (_) => ProductListStore(
                InitialFilters(skus: store.items[index].skus), []),
          )
        ],
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
                    padding: EdgeInsets.only(left: 10, top: 30, bottom: 10),
                    child: Text(
                      'Dargestellte Artikel:',
                      style: TextStyle(fontSize: 22),
                    )),
              ),
              Observer(builder: (context) {
                final store = context.read<ProductListStore>();
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                  ((context, index) {
                    return _createProductWidgetRow(context, index);
                  }),
                  childCount: (store.hits.length / 2).floor(),
                ));
              }),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              const SliverToBoxAdapter(child: ListingTeaser()),
              const SliverToBoxAdapter(child: SizedBox(height: 150)),
            ]),
          );
        }),
      ),
    );
  }

  Widget _createProductWidgetRow(BuildContext context, int index) {
    final store = context.read<ProductListStore>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (store.hits.length > index)
          ProductWidget(store: store, hitIndex: index),
        const SizedBox(width: 10),
        if (store.hits.length > index + 1)
          ProductWidget(store: store, hitIndex: index + 1)
        else
          const Expanded(child: Text('')),
      ],
    );
  }
}
