import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationStack {
  final List<Widget> widgets;
  const NavigationStack({required this.widgets});
}

class NavigationState {
  final List<NavigationStack> stacks;
  final int activeStack;
  const NavigationState({required this.stacks, required this.activeStack});

  Widget get widget => stacks[activeStack].widgets.last;
  bool get canPop => stacks[activeStack].widgets.length > 1;
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({required List<NavigationStack> stacks})
      : super(NavigationState(stacks: stacks, activeStack: 0));

  void push(Widget widget) {
    var stacks = [...state.stacks];
    var widgets = [...stacks[state.activeStack].widgets, widget];
    stacks[state.activeStack] = NavigationStack(widgets: widgets);
    emit(NavigationState(stacks: stacks, activeStack: state.activeStack));
  }

  void pop() {
    var stacks = [...state.stacks];
    var widgets = [...stacks[state.activeStack].widgets];
    if (widgets.length == 1) return;
    widgets.removeLast();
    stacks[state.activeStack] = NavigationStack(widgets: widgets);
    emit(NavigationState(stacks: stacks, activeStack: state.activeStack));
  }

  void clear() {
    var stacks = [...state.stacks];
    var widgets = [stacks[state.activeStack].widgets[0]];
    stacks[state.activeStack] = NavigationStack(widgets: widgets);
    emit(NavigationState(stacks: stacks, activeStack: state.activeStack));
  }

  void setStack(int index) {
    if (index > state.stacks.length) {
      throw 'NavigationCubit:setStack index-out-of-bounds';
    }
    emit(NavigationState(stacks: state.stacks, activeStack: index));
  }
}
