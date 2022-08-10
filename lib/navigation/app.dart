import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/index.dart';
import './bottom_navigation.dart';
import './tab_item.dart';
import '../routes/home/index.dart';
import '../routes/listing/index.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  TabItem _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.listing: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem item) {
    if (item == _currentTab) {
      _navigatorKeys[item]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: [
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.listing),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      HomeRoute.path: (context) => const HomeRoute(),
      ListingRoute.path: (context) => const ListingRoute(),
      // PDPRoute.path: (context) => const PDPRoute(),
    };
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    final routeBuilders = _routeBuilders(context);
    return Offstage(
        offstage: _currentTab != tabItem,
        child: Navigator(
          key: _navigatorKeys[tabItem],
          initialRoute: routePaths[tabItem],
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
                builder: (context) => routeBuilders[settings.name]!(context));
          },
        ));
  }
}