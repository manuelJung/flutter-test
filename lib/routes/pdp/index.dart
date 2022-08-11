import 'package:flutter/material.dart';
import 'package:flutter_app/routes/home/index.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_app/stores/ui.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PDPRoute extends StatelessWidget {
  final ProductListStore store;
  final int index;
  const PDPRoute({super.key, required this.store, required this.index});

  @override
  Widget build(BuildContext context) {
    uiStore.showBottomNavigation = false;
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDP'),
        ),
        body: Hero(
            tag: 'pdp$index',
            child: VisibilityDetector(
                key: const Key('random'),
                onVisibilityChanged: (info) {
                  uiStore.showBottomNavigation = info.visibleBounds.isEmpty;
                },
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeRoute()));
                    },
                    child: const Placeholder()))));
  }
}
