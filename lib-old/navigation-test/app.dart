import 'package:flutter/material.dart';
import 'package:flutter_app/navigation-old/tab_item.dart';

import 'color_detail.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.red;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
        color: activeTabColor[TabItem.red],
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: _push,
          child: const Text(
            'PUSH',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ));
  }

  void _push() {
    Navigator.of(context).push(MaterialPageRoute(
      // we'll look at ColorDetailPage later
      builder: (context) => ColorDetailPage(
        color: activeTabColor[TabItem.red] as Color,
        title: tabName[TabItem.red] as String,
      ),
    ));
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {Key? key, required this.currentTab, required this.onSelectTab})
      : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.red),
        _buildItem(TabItem.green),
        _buildItem(TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
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
    return currentTab == item ? activeTabColor[item] as Color : Colors.grey;
  }
}
