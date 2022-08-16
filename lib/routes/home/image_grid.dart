import 'package:flutter/material.dart';

class ImageGridItem {
  final String label;
  final String imgUrl;
  ImageGridItem({this.label = '', required this.imgUrl});
}

class ImageGrid extends StatelessWidget {
  final int columns;
  final double ratio;

  final List<ImageGridItem> items;
  const ImageGrid({
    super.key,
    required this.columns,
    required this.ratio,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      sliver: SliverGrid.count(
        crossAxisCount: columns,
        childAspectRatio: ratio,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: [
          for (var item in items)
            Stack(children: [
              // Image.network(item.imgUrl),
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(item.imgUrl),
                ),
              ),
              if (item.label != '')
                Positioned.fill(
                    child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      item.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ))
            ])
        ],
      ),
    );
  }
}
