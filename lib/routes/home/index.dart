import 'package:flutter/material.dart';
import 'package:flutter_app/cms/home_page.dart';
import 'package:flutter_app/routes/home/category_grid.dart';
import 'package:flutter_app/routes/home/home_app_bar.dart';
import 'package:flutter_app/routes/home/image_grid.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  final HomePage cms;
  const HomeRoute({required this.cms, super.key});

  @override
  Widget build(BuildContext context) {
    return HomeRouteWrapper(slivers: [
      const HomeAppBar(),
      CategoryGrid(title: cms.categoryLabel, rows: cms.categories),
      ImageGrid(
        columns: 2,
        ratio: 1,
        title: cms.brandLabel,
        items: cms.brands,
      ),
      ImageGrid(
        columns: 2,
        ratio: 2,
        title: cms.imgGrid1Label,
        items: cms.imgGrid1,
      ),
      ImageGrid(
        columns: 1,
        ratio: 2,
        title: cms.imgGrid2Label,
        items: cms.imgGrid2,
      ),
    ]);
  }
}

class HomeRouteWrapper extends StatelessWidget {
  final List<Widget> slivers;
  const HomeRouteWrapper({super.key, required this.slivers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Provider(
        create: (_) => AnimatedValue(0),
        child: Builder(builder: (context) {
          final scrollPos = context.read<AnimatedValue>();
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              var pixels = notification.metrics.pixels;
              if (pixels < 0) pixels = 0;
              scrollPos.setValue(pixels);
              return true;
            },
            child: CustomScrollView(
              slivers: slivers,
            ),
          );
        }),
      ),
    );
  }
}
