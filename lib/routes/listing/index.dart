import 'package:flutter/material.dart';
import 'package:flutter_app/routes/listing/filter_list/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:provider/provider.dart';
import './product_list.dart';

class ListingRoute extends StatelessWidget {
  final InitialFilters initialFilters;
  const ListingRoute({super.key, required this.initialFilters});

  @override
  Widget build(BuildContext context) {
    return Provider<ProductListStore>(
      create: (context) => ProductListStore(initialFilters, [
        const FilterDefinition(
            label: 'Marke',
            key: 'attributes.BRAND.values.value',
            type: FilterType.disjunctive),
        const FilterDefinition(
            label: 'Farbe',
            key: 'attributes.COLOR.values.value',
            type: FilterType.disjunctive),
        const FilterDefinition(
            label: 'Form',
            key: 'attributes.SHAPE.values.value',
            type: FilterType.disjunctive),
      ]),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Listing'),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => FilterListRoute(
                            store: Provider.of<ProductListStore>(context),
                          )));
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.filter_alt_sharp),
          );
        }),
        body: const ProductList(),
      ),
    );
  }
}
