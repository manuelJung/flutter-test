// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UiStore on UiBase, Store {
  late final _$showBottomNavigationAtom =
      Atom(name: 'UiBase.showBottomNavigation', context: context);

  @override
  bool get showBottomNavigation {
    _$showBottomNavigationAtom.reportRead();
    return super.showBottomNavigation;
  }

  @override
  set showBottomNavigation(bool value) {
    _$showBottomNavigationAtom.reportWrite(value, super.showBottomNavigation,
        () {
      super.showBottomNavigation = value;
    });
  }

  @override
  String toString() {
    return '''
showBottomNavigation: ${showBottomNavigation}
    ''';
  }
}
