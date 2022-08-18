import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_app/widgets/product_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SliverProductList extends StatelessWidget {
  final int numHits;
  final int startIndex;
  const SliverProductList({
    super.key,
    required this.numHits,
    required this.startIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final store = context.read<ProductListStore>();
      var widgetHeight = 300;
      var size = MediaQuery.of(context).size;
      final ratio = (size.width / 2) / widgetHeight;
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(((context, index) {
          if (store.hits.length <= index + startIndex) {
            return Container();
          }
          return ProductWidget(store: store, hitIndex: index + startIndex);
        }), childCount: numHits),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: ratio,
        ),
      );
    });
  }
}
