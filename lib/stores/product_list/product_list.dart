// ignore_for_file: library_private_types_in_public_api

import 'package:algolia/algolia.dart';
import 'package:flutter_app/stores/product_list/listing_hit.dart';
import 'package:flutter_app/utils/algolia.dart';
import 'package:mobx/mobx.dart';

part 'product_list.g.dart';

class ProductListStore = _ProductList with _$ProductListStore;

abstract class _ProductList with Store {
  @observable
  ObservableList<ListingHit> hits = ObservableList<ListingHit>();
  @observable
  String query = '';
  @observable
  String category = '';
  @observable
  bool isFetching = false;
  @observable
  String fetchError = '';
  @observable
  int page = 0;

  Map<String, DisjunctiveFilterStore> disjunctiveFilters = {};
  List<FilterDefinition> filterDefinitions = [];

  _ProductList(InitialFilters initFilters, List<FilterDefinition> defs) {
    filterDefinitions = defs;
    for (var def in defs) {
      if (def.type == FilterType.disjunctive) {
        disjunctiveFilters[def.key] = DisjunctiveFilterStore(
            key: def.key, label: def.label, parent: this);
      }
    }

    init(initFilters);
  }

  @action
  void init(InitialFilters initFilters) {
    query = initFilters.query;
    category = initFilters.category;
    page = 0;
    fetch();
  }

  @action
  void setCategory(String category) {
    this.category = category;
    page = 0;
    fetch();
  }

  @action
  void setQuery(String query) {
    this.query = query;
    page = 0;
    fetch();
  }

  @action
  void incrementPage() {
    if (isFetching) return;
    page = page + 1;
    fetch();
  }

  @computed
  bool get canFetchNextPage => hits.length < 25;

  void fetch() async {
    if (isFetching) return;
    print('fetch product_list');
    Action(() {
      isFetching = true;
      fetchError = '';
    })();

    try {
      AlgoliaQuery query = _createQuery();
      AlgoliaQuerySnapshot snap = await query.getObjects();

      Action(() {
        isFetching = false;
        if (page == 0) hits.clear();
        hits.addAll([
          for (var hit in snap.hits.map((hit) => hit.toMap()))
            ListingHit.fromAlgolia(hit)
        ]);

        for (var def in filterDefinitions) {
          if (def.type == FilterType.disjunctive) {
            var filter = disjunctiveFilters[def.key]!;
            if (snap.facets.containsKey(def.type)) {
              filter.options.clear();
            } else {
              List<String> options = snap.facets[def.key].keys.toList();
              filter.options = ObservableList.of(options);
            }
          }
        }
      })();
    } catch (e, stack) {
      print(e);
      print(stack);
      Action(() {
        isFetching = false;
        fetchError = e.toString();
      })();
    }
  }

  AlgoliaQuery _createQuery() {
    AlgoliaQuery query = algolia.instance.index('prod_lusini_de_DE_products');

    query = query.setAttributesToRetrieve([
      'sku',
      'containerID',
      'images',
      'title',
      'flags',
      'attributes',
      'containerID',
      'subtitle',
    ]);

    if (this.query != '') {
      query = query.query(this.query);
    }

    if (filterDefinitions.isNotEmpty) {
      query = query.setFacets([...filterDefinitions.map((def) => def.key)]);
    }

    for (var def in filterDefinitions) {
      for (String opt in (disjunctiveFilters[def.key]?.values ?? [])) {
        query = query.facetFilter('${def.key}:$opt');
      }
    }

    query = query.setPage(page);
    return query;
  }
}

class InitialFilters {
  final String query;
  final String category;
  const InitialFilters({this.query = '', this.category = ''});
}

enum FilterType { disjunctive, numeric }

class FilterDefinition {
  const FilterDefinition(
      {required this.label, required this.key, required this.type});
  final String label;
  final String key;
  final FilterType type;
}

class DisjunctiveFilterStore = _DisjunctiveFilter with _$DisjunctiveFilterStore;

abstract class _DisjunctiveFilter with Store {
  final String key;
  final String label;
  final _ProductList parent;

  @observable
  ObservableList<String> options = ObservableList<String>();

  @observable
  ObservableList<String> values = ObservableList<String>();

  _DisjunctiveFilter(
      {required this.key, required this.label, required this.parent});

  @action
  void toggleValue(String value) {
    if (values.contains(value)) {
      values.remove(value);
    } else {
      values.add(value);
    }
    parent.page = 0;
    parent.fetch();
  }
}
