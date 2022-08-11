import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_app/stores/ui.dart';
import '../pdp/index.dart';

class ProductWidget extends StatelessWidget {
  final ProductListStore store;
  final int hitIndex;
  const ProductWidget({Key? key, required this.store, required this.hitIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PDPRoute(
                      store: store,
                      index: hitIndex,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Placeholder(fallbackHeight: ((size.width / 2) * 1.5)),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                store.hits[hitIndex].title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 20, height: 1.5),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
