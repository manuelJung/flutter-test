import 'package:flutter/material.dart';
import 'package:flutter_app/containers/app_scaffold.dart';

class PDP extends StatelessWidget {
  final String productNumber;
  const PDP({Key? key, required this.productNumber}) : super(key: key);

  static const routeName = '/pdp';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBarTitle: 'PDP',
        body: Center(
          child: Text('Hello $productNumber'),
        ));
  }
}
