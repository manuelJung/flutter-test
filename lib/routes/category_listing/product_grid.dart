import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_app/widgets/product_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final int startIndex;
  final int numHits;
  const ProductGrid({
    super.key,
    required this.startIndex,
    this.numHits = -1,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var store = context.read<ProductListStore>();
        var endIndex =
            numHits == -1 ? store.hits.length - 1 : startIndex + numHits;
        var rows = ((endIndex - startIndex) / 2).ceil();
        var maxRows = (((store.hits.length - 1) - startIndex) / 2).ceil();

        return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          var i = (index * 2) + startIndex;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProductWidget(store: store, hitIndex: i),
              const SizedBox(width: 10),
              if (store.hits.length > i + 1)
                ProductWidget(store: store, hitIndex: i + 1)
              else
                const Expanded(child: Text(''))
            ],
          );
        }, childCount: maxRows < rows ? maxRows : rows));
      },
    );
  }
}
