import 'package:flutter/material.dart';
import 'package:flutter_app/atoms/labeled_box.dart';
import 'package:flutter_app/containers/app_scaffold.dart';

class HomeRoute extends StatelessWidget {
  final int bottomBarIndex;
  const HomeRoute({Key? key, required this.bottomBarIndex}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        navigationIndex: bottomBarIndex,
        appBarTitle: 'Home',
        body: ListView(
          children: const [CategoryList(), ImageGrid(), CategoryList()],
        ));
  }
}

double getHeight(
    {required int items,
    required int columns,
    required double spacing,
    required double screenWidth,
    double fixedHeight = 0,
    double ratio = 0}) {
  var rows = (items / columns).ceil();
  var itemWidth = ((screenWidth - ((columns + 1) * spacing)) / columns);
  var height = (rows - 1) * spacing;
  if (ratio != 0) {
    height += rows * (itemWidth / ratio);
  }
  if (fixedHeight != 0) {
    height += rows * fixedHeight;
    height -= spacing;
  }
  return height;
}

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var columns = 2;
    double spacing = 10;
    var ratio = (2 / 1);
    const items = [
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
    ];
    return LabeledBox(
        label: 'Themen',
        child: SizedBox(
          height: getHeight(
              items: items.length,
              columns: columns,
              spacing: spacing,
              screenWidth: size.width,
              ratio: ratio),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            childAspectRatio: ratio,
            mainAxisSpacing: spacing,
            padding: EdgeInsets.only(left: spacing, right: spacing),
            children: items,
          ),
        ));
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var itemWidth = size.width / 2;
    double itemHeight = 50;
    double spacing = 10;
    var columns = 2;

    const items = [
      CategoryListItem(title: 'Abendkleider'),
      CategoryListItem(title: 'Schuhe'),
      CategoryListItem(title: 'Teller'),
      CategoryListItem(title: 'Business'),
      CategoryListItem(title: 'Besteck'),
      CategoryListItem(title: 'Serien'),
    ];

    return LabeledBox(
      label: 'Kategorien',
      child: SizedBox(
        height: getHeight(
            items: items.length,
            columns: columns,
            spacing: spacing,
            screenWidth: size.width,
            fixedHeight: itemHeight),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          childAspectRatio: (itemWidth / itemHeight),
          mainAxisSpacing: spacing,
          padding: EdgeInsets.only(left: spacing, right: spacing),
          children: items,
        ),
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final String title;
  const CategoryListItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromRGBO(230, 230, 230, 1),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const FlutterLogo(),
          ),
          Text(title),
        ],
      ),
    );
  }
}
