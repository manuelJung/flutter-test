import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import './loading_indicator.dart';
import './product_widget.dart';

class ListingRoute extends StatelessWidget {
  final InitialFilters initialFilters;
  const ListingRoute({super.key, required this.initialFilters});

  @override
  Widget build(BuildContext context) {
    return Provider<ProductList>(
      create: (_) => ProductList(initialFilters, []),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Listing'),
        ),
        body: _buildProductList(),
      ),
    );
  }

  int _calcItemCount(ProductList store) {
    return store.canFetchNextPage
        ? (store.hits.length / 2).ceil() + 1
        : (store.hits.length / 2).ceil();
  }

  Widget _createProductListRow(ProductList store, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProductWidget(hit: store.hits[i * 2 + 0]),
        (store.hits.length - 2) >= (i * 2)
            ? ProductWidget(hit: store.hits[i * 2 + 1])
            : const Expanded(child: Text(''))
      ],
    );
  }

  Widget _buildProductList() {
    return Observer(
      builder: (context) {
        return Center(child: Observer(builder: (_) {
          var store = context.read<ProductList>();
          return ListView.builder(
              itemCount: _calcItemCount(store),
              itemBuilder: (context, i) {
                if (i == (store.hits.length / 2).ceil()) {
                  return const LoadingIndicator();
                }
                return _createProductListRow(store, i);
              });
        }));
      },
    );
  }
}
