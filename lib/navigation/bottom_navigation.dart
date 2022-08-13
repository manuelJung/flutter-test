import 'package:flutter/material.dart';
import './tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(context, TabItem.home),
        _buildItem(context, TabItem.discover),
        _buildItem(context, TabItem.listing),
        _buildItem(context, TabItem.cart),
        _buildItem(context, TabItem.settings),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: Theme.of(context).colorScheme.primary,
    );
  }

  BottomNavigationBarItem _buildItem(BuildContext context, TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        routeIcons[tabItem],
        color: _colorTabMatching(context, tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorTabMatching(BuildContext context, TabItem item) {
    return currentTab == item
        ? Theme.of(context).colorScheme.primary
        : Colors.grey;
  }
}
