// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CMSStore on _CMSStore, Store {
  late final _$dataHomeAtom =
      Atom(name: '_CMSStore.dataHome', context: context);

  @override
  ObservableMap<String, HomePage> get dataHome {
    _$dataHomeAtom.reportRead();
    return super.dataHome;
  }

  @override
  set dataHome(ObservableMap<String, HomePage> value) {
    _$dataHomeAtom.reportWrite(value, super.dataHome, () {
      super.dataHome = value;
    });
  }

  late final _$categoryListingAtom =
      Atom(name: '_CMSStore.categoryListing', context: context);

  @override
  ObservableMap<String, CategoryListingPage> get categoryListing {
    _$categoryListingAtom.reportRead();
    return super.categoryListing;
  }

  @override
  set categoryListing(ObservableMap<String, CategoryListingPage> value) {
    _$categoryListingAtom.reportWrite(value, super.categoryListing, () {
      super.categoryListing = value;
    });
  }

  @override
  String toString() {
    return '''
dataHome: ${dataHome},
categoryListing: ${categoryListing}
    ''';
  }
}
