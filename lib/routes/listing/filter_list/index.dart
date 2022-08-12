import 'package:flutter/material.dart';
import 'package:flutter_app/routes/listing/filter_list/disjunctive_filter.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';

class FilterListRoute extends StatelessWidget {
  final ProductListStore store;
  const FilterListRoute({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filter'),
        ),
        body: ListView(
          children: [
            for (var filter in store.filterDefinitions)
              Tile(
                label: filter.label,
                selected: const [],
                store: store.disjunctiveFilters[filter.key]!,
              )
          ],
        ));
  }
}

class Tile extends StatelessWidget {
  final String label;
  final List<String> selected;
  final DisjunctiveFilterStore store;
  const Tile(
      {Key? key,
      required this.label,
      required this.selected,
      required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide()),
      ),
      child: ListTile(
        minVerticalPadding: 20,
        title: Text(label),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DisjunctiveFilterRoute(store: store)));
        },
        // subtitle: Text(selected.join(", ")),
        trailing: const Icon(Icons.arrow_right_sharp),
      ),
    );
  }
}
