import 'package:flutter/material.dart';
import 'package:flutter_app/cms/category_listing_page.dart';
import 'package:flutter_app/routes/category_listing/custom_app_bar.dart';
import 'package:flutter_app/routes/listing/filter_list/index.dart';
import 'package:flutter_app/slivers/sliver_product_grid.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CategoryListingRoute extends StatelessWidget {
  final CategoryListingPage cms;
  const CategoryListingRoute({super.key, required this.cms});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ProductListStore(InitialFilters(query: cms.category), [
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
      child: Observer(builder: (context) {
        var store = context.read<ProductListStore>();
        return CategoryListingRouteWrapper(
          cms: cms,
          slivers: [
            CustomAppBar(title: cms.title),
            const SliverProductGrid(startIndex: 0, numHits: 6),
            if (store.hits.length >= 6)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  color: Colors.amber[200],
                  height: 200,
                  child: const Center(
                    child: Text('Intersticial 1'),
                  ),
                ),
              ),
            const SliverProductGrid(startIndex: 6, numHits: 10),
            if (store.hits.length >= 16)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  color: Colors.amber[100],
                  height: 200,
                  child: const Center(
                    child: Text('Intersticial 2'),
                  ),
                ),
              ),
            const SliverProductGrid(startIndex: 16),
          ],
        );
      }),
    );
  }
}

class CategoryListingRouteWrapper extends StatelessWidget {
  final List<Widget> slivers;
  final CategoryListingPage cms;
  const CategoryListingRouteWrapper({
    super.key,
    required this.slivers,
    required this.cms,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
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
      ),
      body: Observer(builder: (context) {
        var store = Provider.of<ProductListStore>(context);
        if (store.hits.isEmpty) {
          return const Text('');
        }
        return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.extentAfter < 300 &&
                  !store.isFetching &&
                  store.canFetchNextPage) {
                store.incrementPage();
              }
              return true;
            },
            child: CustomScrollView(slivers: slivers));
      }),
    );
  }
}
