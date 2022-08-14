// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdp.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PDPStore on _PDP, Store {
  Computed<PDPHit>? _$displayVariantComputed;

  @override
  PDPHit get displayVariant =>
      (_$displayVariantComputed ??= Computed<PDPHit>(() => super.displayVariant,
              name: '_PDP.displayVariant'))
          .value;

  late final _$hitsAtom = Atom(name: '_PDP.hits', context: context);

  @override
  ObservableList<PDPHit> get hits {
    _$hitsAtom.reportRead();
    return super.hits;
  }

  @override
  set hits(ObservableList<PDPHit> value) {
    _$hitsAtom.reportWrite(value, super.hits, () {
      super.hits = value;
    });
  }

  late final _$isFetchingAtom = Atom(name: '_PDP.isFetching', context: context);

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

  late final _$fetchErrorAtom = Atom(name: '_PDP.fetchError', context: context);

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

  @override
  String toString() {
    return '''
hits: ${hits},
isFetching: ${isFetching},
fetchError: ${fetchError},
displayVariant: ${displayVariant}
    ''';
  }
}

mixin _$FilterStore on _Filter, Store {
  late final _$optionsAtom = Atom(name: '_Filter.options', context: context);

  @override
  ObservableList<FilterOption> get options {
    _$optionsAtom.reportRead();
    return super.options;
  }

  @override
  set options(ObservableList<FilterOption> value) {
    _$optionsAtom.reportWrite(value, super.options, () {
      super.options = value;
    });
  }

  late final _$valueAtom = Atom(name: '_Filter.value', context: context);

  @override
  String get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(String value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$_FilterActionController =
      ActionController(name: '_Filter', context: context);

  @override
  dynamic setValue(String value) {
    final _$actionInfo =
        _$_FilterActionController.startAction(name: '_Filter.setValue');
    try {
      return super.setValue(value);
    } finally {
      _$_FilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
options: ${options},
value: ${value}
    ''';
  }
}
