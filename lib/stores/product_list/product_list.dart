// ignore_for_file: library_private_types_in_public_api

import 'package:algolia/algolia.dart';
import 'package:flutter_app/utils/algolia.dart';
import 'package:mobx/mobx.dart';

part 'product_list.g.dart';

class ProductListStore = _ProductList with _$ProductListStore;

abstract class _ProductList with Store {
  @observable
  ObservableList<Hit> hits = ObservableList<Hit>();
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
    Action(() {
      isFetching = true;
      fetchError = '';
    })();

    try {
      AlgoliaQuery query = _createQuery();
      AlgoliaQuerySnapshot snap = await query.getObjects();
      String imgHost =
          'https://res.cloudinary.com/lusini/w_500,h_500,q_70,c_pad,f_auto';

      Action(() {
        isFetching = false;
        if (page == 0) hits.clear();
        hits.addAll([
          for (var hit in snap.hits.map((hit) => hit.toMap()))
            Hit(
                title: hit['title'],
                sku: hit['sku'],
                subtitle: hit['subtitle'],
                productNumber: hit['containerID'],
                imgUrl: '$imgHost/${hit['images']['imageWeb'][0]['url']}')
        ]);

        // print(snap.facets.keys.toList());
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
    } catch (e) {
      print(e);
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

    query = query.setPage(page);
    query = query.setFacets([...filterDefinitions.map((def) => def.key)]);

    for (var def in filterDefinitions) {
      for (String opt in (disjunctiveFilters[def.key]?.values ?? [])) {
        query = query.facetFilter('${def.key}:$opt');
      }
    }

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

class Hit {
  final String title;
  final String imgUrl;
  final String sku;
  final String productNumber;
  final String subtitle;
  const Hit(
      {required this.title,
      required this.imgUrl,
      required this.sku,
      required this.subtitle,
      required this.productNumber});
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
