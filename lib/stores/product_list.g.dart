// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductListStore on ProductListBase, Store {
  Computed<bool>? _$canFetchNextPageComputed;

  @override
  bool get canFetchNextPage => (_$canFetchNextPageComputed ??= Computed<bool>(
          () => super.canFetchNextPage,
          name: 'ProductListBase.canFetchNextPage'))
      .value;

  late final _$hitsAtom = Atom(name: 'ProductListBase.hits', context: context);

  @override
  ObservableList<Hit> get hits {
    _$hitsAtom.reportRead();
    return super.hits;
  }

  @override
  set hits(ObservableList<Hit> value) {
    _$hitsAtom.reportWrite(value, super.hits, () {
      super.hits = value;
    });
  }

  late final _$queryAtom =
      Atom(name: 'ProductListBase.query', context: context);

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: 'ProductListBase.category', context: context);

  @override
  String get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(String value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$isFetchingAtom =
      Atom(name: 'ProductListBase.isFetching', context: context);

  @override
  bool get isFetching {
    _$isFetchingAtom.reportRead();
    return super.isFetching;
  }

  @override
  set isFetching(bool value) {
    _$isFetchingAtom.reportWrite(value, super.isFetching, () {
      super.isFetching = value;
    });
  }

  late final _$fetchErrorAtom =
      Atom(name: 'ProductListBase.fetchError', context: context);

  @override
  String get fetchError {
    _$fetchErrorAtom.reportRead();
    return super.fetchError;
  }

  @override
  set fetchError(String value) {
    _$fetchErrorAtom.reportWrite(value, super.fetchError, () {
      super.fetchError = value;
    });
  }

  late final _$pageAtom = Atom(name: 'ProductListBase.page', context: context);

  @override
  num get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(num value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$ProductListBaseActionController =
      ActionController(name: 'ProductListBase', context: context);

  @override
  void init(InitialFilters initFilters) {
    final _$actionInfo = _$ProductListBaseActionController.startAction(
        name: 'ProductListBase.init');
    try {
      return super.init(initFilters);
    } finally {
      _$ProductListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(String category) {
    final _$actionInfo = _$ProductListBaseActionController.startAction(
        name: 'ProductListBase.setCategory');
    try {
      return super.setCategory(category);
    } finally {
      _$ProductListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuery(String query) {
    final _$actionInfo = _$ProductListBaseActionController.startAction(
        name: 'ProductListBase.setQuery');
    try {
      return super.setQuery(query);
    } finally {
      _$ProductListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementPage() {
    final _$actionInfo = _$ProductListBaseActionController.startAction(
        name: 'ProductListBase.incrementPage');
    try {
      return super.incrementPage();
    } finally {
      _$ProductListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hits: ${hits},
query: ${query},
category: ${category},
isFetching: ${isFetching},
fetchError: ${fetchError},
page: ${page},
canFetchNextPage: ${canFetchNextPage}
    ''';
  }
}

mixin _$DisjunctiveFilterStore on DisjunctiveFilterBase, Store {
  late final _$optionsAtom =
      Atom(name: 'DisjunctiveFilterBase.options', context: context);

  @override
  ObservableList<String> get options {
    _$optionsAtom.reportRead();
    return super.options;
  }

  @override
  set options(ObservableList<String> value) {
    _$optionsAtom.reportWrite(value, super.options, () {
      super.options = value;
    });
  }

  late final _$valuesAtom =
      Atom(name: 'DisjunctiveFilterBase.values', context: context);

  @override
  ObservableList<String> get values {
    _$valuesAtom.reportRead();
    return super.values;
  }

  @override
  set values(ObservableList<String> value) {
    _$valuesAtom.reportWrite(value, super.values, () {
      super.values = value;
    });
  }

  late final _$DisjunctiveFilterBaseActionController =
      ActionController(name: 'DisjunctiveFilterBase', context: context);

  @override
  void toggleValue(String value) {
    final _$actionInfo = _$DisjunctiveFilterBaseActionController.startAction(
        name: 'DisjunctiveFilterBase.toggleValue');
    try {
      return super.toggleValue(value);
    } finally {
      _$DisjunctiveFilterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
options: ${options},
values: ${values}
    ''';
  }
}
