import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';

class ProductWidget extends StatelessWidget {
  final ProductListStore store;
  final int hitIndex;
  const ProductWidget({Key? key, required this.store, required this.hitIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var hit = store.hits[hitIndex];
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
            Image.network(hit.imgUrl,
                height: ((size.width / 2)), width: size.width / 2),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                hit.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
