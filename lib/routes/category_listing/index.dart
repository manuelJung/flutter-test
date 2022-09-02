import 'package:flutter/material.dart';
import 'package:flutter_app/cms/category_listing_page.dart';
import 'package:flutter_app/routes/category_listing/custom_app_bar.dart';
import 'package:flutter_app/routes/listing/filter_list/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:provider/provider.dart';

class CategoryListingRoute extends StatelessWidget {
  final CategoryListingPage cms;
  const CategoryListingRoute({super.key, required this.cms});

  @override
  Widget build(BuildContext context) {
    return CategoryListingRouteWrapper(
      cms: cms,
      slivers: [
        CustomAppBar(title: cms.title),
      ],
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
      child: Scaffold(
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
        body: CustomScrollView(slivers: slivers),
      ),
    );
  }
}
