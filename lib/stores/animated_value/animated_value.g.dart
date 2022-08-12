// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animated_value.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnimatedValue on _AnimatedValue, Store {
  late final _$valueAtom = Atom(name: '_AnimatedValue.value', context: context);

  @override
  double get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(double value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$_AnimatedValueActionController =
      ActionController(name: '_AnimatedValue', context: context);

  @override
  void increment() {
    final _$actionInfo = _$_AnimatedValueActionController.startAction(
        name: '_AnimatedValue.increment');
    try {
      return super.increment();
    } finally {
      _$_AnimatedValueActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValue(double n) {
    final _$actionInfo = _$_AnimatedValueActionController.startAction(
        name: '_AnimatedValue.setValue');
    try {
      return super.setValue(n);
    } finally {
      _$_AnimatedValueActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
