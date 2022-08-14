// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impressions.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImpressionsStore on _ImpressionsStore, Store {
  late final _$itemsAtom =
      Atom(name: '_ImpressionsStore.items', context: context);

  @override
  ObservableList<ImpressionItem> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<ImpressionItem> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$pageAtom =
      Atom(name: '_ImpressionsStore.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$isFetchingAtom =
      Atom(name: '_ImpressionsStore.isFetching', context: context);

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
      Atom(name: '_ImpressionsStore.fetchError', context: context);

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

  late final _$_ImpressionsStoreActionController =
      ActionController(name: '_ImpressionsStore', context: context);

  @override
  void extend() {
    final _$actionInfo = _$_ImpressionsStoreActionController.startAction(
        name: '_ImpressionsStore.extend');
    try {
      return super.extend();
    } finally {
      _$_ImpressionsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
page: ${page},
isFetching: ${isFetching},
fetchError: ${fetchError}
    ''';
  }
}
