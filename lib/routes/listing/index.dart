import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:provider/provider.dart';
import './product_list.dart';

class ListingRoute extends StatelessWidget {
  final InitialFilters initialFilters;
  const ListingRoute({super.key, required this.initialFilters});

  @override
  Widget build(BuildContext context) {
    return Provider<ProductListStore>(
      create: (_) => ProductListStore(initialFilters, []),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Listing'),
        ),
        body: const ProductList(),
      ),
    );
  }
}
