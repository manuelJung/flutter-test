import 'package:flutter/material.dart';
import 'package:flutter_app/cms/cms_store.dart';
import 'package:flutter_app/routes/cart/index.dart';
import 'package:flutter_app/routes/discover/index.dart';
import 'package:flutter_app/routes/settings/index.dart';
import 'package:flutter_app/routes/wishlist/index.dart';
import 'package:flutter_app/stores/ui/ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import './bottom_navigation.dart';
import './tab_item.dart';
import '../routes/home/index.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  TabItem _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.discover: GlobalKey<NavigatorState>(),
    TabItem.wishlist: GlobalKey<NavigatorState>(),
    TabItem.cart: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
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
          _buildOffstageNavigator(TabItem.discover),
          _buildOffstageNavigator(TabItem.wishlist),
          _buildOffstageNavigator(TabItem.cart),
          _buildOffstageNavigator(TabItem.settings),
        ]),
        bottomNavigationBar: Observer(builder: (context) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: uiStore.showBottomNavigation ? 55 : 0,
            child: Wrap(
              children: [
                BottomNavigation(
                  currentTab: _currentTab,
                  onSelectTab: _selectTab,
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      routePaths[TabItem.home]!: (context) =>
          HomeRoute(cms: context.read<CMSStore>().getHomePage('home')),
      routePaths[TabItem.discover]!: (context) => const DiscoverRoute(),
      routePaths[TabItem.wishlist]!: (context) => const WishlistRoute(),
      routePaths[TabItem.cart]!: (context) => const CartRoute(),
      routePaths[TabItem.settings]!: (context) => const SettingsRoute(),
    };
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    final routeBuilders = _routeBuilders(context);
    return Offstage(
        offstage: _currentTab != tabItem,
        child: Navigator(
          key: _navigatorKeys[tabItem],
          initialRoute: routePaths[tabItem],
          observers: [MaterialApp.createMaterialHeroController()],
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
                builder: (context) => routeBuilders[settings.name]!(context));
          },
        ));
  }
}
