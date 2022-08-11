import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';

class PDPRoute extends StatelessWidget {
  final ProductListStore store;
  final int index;
  const PDPRoute({super.key, required this.store, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDP'),
        ),
        body: Hero(tag: 'pdp$index', child: const Placeholder()));
  }
}
