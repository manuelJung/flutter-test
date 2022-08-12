// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'ui.g.dart';

class UiStore = _Ui with _$UiStore;

abstract class _Ui with Store {
  @observable
  bool showBottomNavigation = true;
}

final uiStore = UiStore();
