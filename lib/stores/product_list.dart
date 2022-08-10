import 'package:mobx/mobx.dart';

part 'product_list.g.dart';

class ProductList = ProductListBase with _$ProductList;

abstract class ProductListBase with Store {
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
  num page = 0;

  Map<String, DisjunctiveFilter> disjunctiveFilters = {};
  List<FilterDefinition> filterDefinitions = [];

  ProductListBase(InitialFilters initFilters, List<FilterDefinition> defs) {
    filterDefinitions = defs;
    for (var def in defs) {
      if (def.type == FilterType.disjunctive) {
        disjunctiveFilters[def.key] =
            DisjunctiveFilter(key: def.key, label: def.label, parent: this);
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
    fetch(true);
  }

  @computed
  bool get canFetchNextPage => hits.length < 25;

  void fetch([bool append = false]) async {
    Action(() {
      isFetching = true;
      fetchError = '';
    })();

    try {
      await Future.delayed(const Duration(milliseconds: 800));
      Action(() {
        isFetching = false;
        if (!append) hits.clear();
        hits.addAll(List.generate(
            10, (index) => Hit(title: 'Article ${index + hits.length}')));

        for (var def in filterDefinitions) {
          if (def.type == FilterType.disjunctive) {
            var filter = disjunctiveFilters[def.key]!;
            filter.options = ObservableList.of(['a', 'b', 'c']);
          }
        }
      })();
    } catch (e) {
      Action(() {
        isFetching = false;
        fetchError = e.toString();
      })();
    }
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
  const Hit({required this.title});
}

class DisjunctiveFilter = DisjunctiveFilterBase with _$DisjunctiveFilter;

abstract class DisjunctiveFilterBase with Store {
  final String key;
  final String label;
  final ProductListBase parent;

  @observable
  ObservableList<String> options = ObservableList<String>();

  @observable
  ObservableList<String> values = ObservableList<String>();

  DisjunctiveFilterBase(
      {required this.key, required this.label, required this.parent});

  @action
  void toggleValue(String value) {
    if (values.contains(value)) {
      values.remove(value);
    } else {
      values.add(value);
    }
    parent.fetch();
  }
}
