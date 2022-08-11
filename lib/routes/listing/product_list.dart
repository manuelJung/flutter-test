import 'package:flutter_mobx/flutter_mobx.dart';
import './product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/stores/product_list.dart';
import './loading_indicator.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Observer(builder: (_) {
      var store = context.read<ProductListStore>();
      return ListView.builder(
          itemCount: _calcItemCount(store),
          itemBuilder: (context, i) {
            if (i == (store.hits.length / 2).ceil()) {
              return const LoadingIndicator();
            }
            return _createProductListRow(store, i);
          });
    }));
  }

  int _calcItemCount(ProductListStore store) {
    return store.canFetchNextPage
        ? (store.hits.length / 2).ceil() + 1
        : (store.hits.length / 2).ceil();
  }

  Widget _createProductListRow(ProductListStore store, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProductWidget(store: store, hitIndex: i * 2 + 0),
        (store.hits.length - 2) >= (i * 2)
            ? ProductWidget(
                store: store,
                hitIndex: i * 2 + 1,
              )
            : const Expanded(child: Text(''))
      ],
    );
  }
}
