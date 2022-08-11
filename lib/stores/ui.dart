import 'package:mobx/mobx.dart';

part 'ui.g.dart';

class UiStore = UiBase with _$UiStore;

abstract class UiBase with Store {
  @observable
  bool showBottomNavigation = true;
}

final uiStore = UiStore();
