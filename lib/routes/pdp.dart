import 'package:flutter/material.dart';
import 'package:flutter_app/containers/app_scaffold.dart';

class PDP extends StatelessWidget {
  final int bottomBarIndex;
  final String productNumber;
  const PDP(
      {Key? key, required this.productNumber, required this.bottomBarIndex})
      : super(key: key);

  static const routeName = '/pdp';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        navigationIndex: bottomBarIndex,
        appBarTitle: 'PDP',
        body: Center(
          child: Text('Hello $productNumber'),
        ));
  }
}
