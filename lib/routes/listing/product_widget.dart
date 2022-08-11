import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';
import '../pdp/index.dart';

class ProductWidget extends StatelessWidget {
  final Hit hit;
  const ProductWidget({Key? key, required this.hit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const PDPRoute()));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            const Placeholder(fallbackHeight: 400),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                hit.title,
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
