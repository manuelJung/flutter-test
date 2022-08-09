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
  const AppScaffold({
    Key? key,
    required this.body,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: AppBar(
          title: Text(appBarTitle),
          leading: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
            return InkWell(
              child: state.canPop
                  ? const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )
                  : null,
              onTap: () {
                context.read<NavigationCubit>().pop();
              },
            );
          })),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          ],
          onTap: (n) => {context.read<NavigationCubit>().setStack(n)},
          currentIndex: state.activeStack,
        ),
      ),
    );
  }
}
