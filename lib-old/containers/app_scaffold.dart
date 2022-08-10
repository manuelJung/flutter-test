import 'package:flutter/material.dart';
import 'package:flutter_app/routes/home.dart';
import 'package:flutter_app/routes/product_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../stores/navigation.dart';

class AppNavigationItems {
  Widget icon;
  String label;
  String route;
  AppNavigationItems(
      {required this.icon, required this.label, required this.route});
}

final navItems = [
  AppNavigationItems(
      icon: const Icon(Icons.home), label: 'Home', route: HomeRoute.routeName),
  AppNavigationItems(
      icon: const Icon(Icons.list),
      label: 'List',
      route: ProductListRoute.routeName)
];

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String appBarTitle;
  final int navigationIndex;
  const AppScaffold({
    Key? key,
    required this.body,
    required this.appBarTitle,
    required this.navigationIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      bottomNavigationBar: NavigationBar(index: navigationIndex),
    );
  }
}

class NavigationBar extends StatelessWidget {
  final int index;
  const NavigationBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
      ],
      onTap: (n) {
        var item = navItems[n];
        if (item.route == HomeRoute.routeName) {
          Navigator.pushReplacement(
              context,
              NoAnimationMaterialPageRoute(
                  builder: (context) => const HomeRoute(bottomBarIndex: 0)));
        }
        if (item.route == ProductListRoute.routeName) {
          Navigator.pushReplacement(
              context,
              NoAnimationMaterialPageRoute(
                  builder: (context) => const ProductListRoute(
                        bottomBarIndex: 1,
                      )));
        }
      },
      currentIndex: index,
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
