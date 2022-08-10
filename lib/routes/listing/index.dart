import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:provider/provider.dart';
import '../pdp/index.dart';

class ListingRoute extends StatelessWidget {
  final InitialFilters initialFilters;
  const ListingRoute({super.key, required this.initialFilters});

  @override
  Widget build(BuildContext context) {
    return Provider<ProductList>(
      create: ((_) => ProductList(initialFilters, [])),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Listing'),
        ),
        body: Center(
            child: ElevatedButton(
          child: const Text('Open pdp'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PDPRoute()),
            );
          },
        )),
      ),
    );
  }
}
