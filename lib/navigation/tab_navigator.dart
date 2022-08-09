import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/tab_item.dart';

import 'color_detail.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

// 2
class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  // 3
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: Colors.amber,
            title: 'Colors List Page',
            // color: TabHelper.color(tabItem),
            // title: TabHelper.description(tabItem),
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: Colors.amberAccent,
            title: 'Color Detail Page',
            // color: TabHelper.color(tabItem),
            // title: TabHelper.description(tabItem),
            materialIndex: materialIndex,
          ),
    };
  }

  // 4
  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }

  // 5
  void _push(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),
    );
  }
}
