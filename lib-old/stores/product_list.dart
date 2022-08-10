import 'package:flutter_bloc/flutter_bloc.dart';

class Hit {
  const Hit({required this.title});
  final String title;
}

class FilterValues {
  final String query;
  final int page;
  final Map<String, List<String>> disjunctiveFilters;
  const FilterValues(
      {required this.query,
      required this.disjunctiveFilters,
      required this.page});
  factory FilterValues.initial() {
    return const FilterValues(query: '', disjunctiveFilters: {}, page: 0);
  }
  factory FilterValues.create({
    FilterValues? from,
    String? query,
    int? page,
    Map<String, List<String>>? disjunctiveFilters,
  }) {
    var state = from ?? FilterValues.initial();
    return FilterValues(
        query: query ?? state.query,
        disjunctiveFilters: disjunctiveFilters ?? state.disjunctiveFilters,
        page: page ?? state.page);
  }
}

class ProductListState {
  final FilterValues filterValues;
  final bool isFetching;
  final List<Hit> hits;
  final String error;
  const ProductListState({
    required this.filterValues,
    required this.isFetching,
    required this.hits,
    required this.error,
  });
  factory ProductListState.initial() {
    return ProductListState(
        filterValues: FilterValues.initial(),
        isFetching: false,
        hits: const [],
        error: '');
  }
  factory ProductListState.create({
    ProductListState? from,
    FilterValues? filterValues,
    bool? isFetching,
    List<Hit>? hits,
    String? error,
  }) {
    var state = from ?? ProductListState.initial();
    return ProductListState(
      filterValues: filterValues ?? state.filterValues,
      isFetching: isFetching ?? state.isFetching,
      hits: hits ?? state.hits,
      error: error ?? state.error,
    );
  }
}

enum FilterType { disjunctive, numeric }

class FilterDefinition {
  const FilterDefinition(
      {required this.label, required this.key, required this.type});
  final String label;
  final String key;
  final FilterType type;
}

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(ProductListState state) : super(state);

  // final List<FilterDefinition> _filterDefinitions = [
  //   const FilterDefinition(label: 'Größe', key: 'size', type: FilterType.disjunctive),
  //   const FilterDefinition(label: 'Farbe', key: 'color', type: FilterType.disjunctive),
  // ];

  void init(FilterValues values) {
    emit(ProductListState.create(filterValues: values));
    _fetch();
  }

  void setQuery(String query) {
    emit(ProductListState.create(
        from: state,
        filterValues: FilterValues.create(
            from: state.filterValues, query: query, page: 0)));
    _fetch();
  }

  void incrementPage() {
    if (state.isFetching) return;
    emit(ProductListState.create(
        from: state,
        filterValues: FilterValues.create(
          from: state.filterValues,
          page: state.filterValues.page + 1,
        )));
    _fetch(true);
  }

  void _fetch([bool increment = false]) async {
    emit(ProductListState.create(from: state, isFetching: true, error: ''));

    try {
      await Future.delayed(const Duration(milliseconds: 800));
      var initialHits = increment ? [...state.hits] : [];
      emit(ProductListState.create(from: state, isFetching: false, hits: [
        ...initialHits,
        for (int i = 0; i < 23; i++) Hit(title: 'Article $i')
      ]));
    } catch (e) {
      emit(ProductListState.create(
          from: state, isFetching: false, error: e.toString()));
    }
  }
}
