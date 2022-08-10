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
        _buildItem(TabItem.home),
        _buildItem(TabItem.listing),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: Colors.amber,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? Colors.amber : Colors.grey;
  }
}
