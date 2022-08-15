import 'package:flutter/material.dart';
import 'package:flutter_app/routes/impression/index.dart';
import 'package:flutter_app/stores/impression/impressions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class DiscoverRoute extends StatelessWidget {
  const DiscoverRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Entdecken')),
      body: Provider(
          create: (_) => ImpressionsStore(),
          child: Observer(builder: (context) {
            var store = context.read<ImpressionsStore>();
            if (store.isFetching && store.items.isEmpty) {
              return Container(color: Colors.transparent);
            }
            return GridView.custom(
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(4, 4),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(3, 3),
                  QuiltedGridTile(3, 3),
                  QuiltedGridTile(4, 4),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(2, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate((context, index) {
                var item = store.items[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImpressionPage(
                                    store: store,
                                    index: index,
                                  )));
                    },
                    child: Image.network(item.img));
              }, childCount: store.items.length),
            );
            // return ListView.builder(
            //     itemCount: store.items.length,
            //     itemBuilder: ((context, index) {
            //       var item = store.items[index];
            //       return Image.network(item.img);
            //     }));
          })),
    );
  }
}
