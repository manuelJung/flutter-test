import 'package:flutter/material.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:flutter_app/stores/product_list/listing_hit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SheetTitle extends StatelessWidget {
  final ListingHit listingHit;
  const SheetTitle({super.key, required this.listingHit});

  @override
  Widget build(BuildContext context) {
    var scrollPos = context.read<AnimatedValue>();
    return Observer(builder: (context) {
      double rounding = scrollPos.interpolate(xs: [0, 0.6, 1], ys: [10, 10, 0]);
      return Container(
        height: 100,
        decoration: BoxDecoration(
          border: const Border(
            top: BorderSide(color: Colors.grey, width: 0),
            bottom: BorderSide(color: Colors.grey, width: 0),
            left: BorderSide(color: Colors.grey, width: 0),
            right: BorderSide(color: Colors.grey, width: 0),
          ),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(rounding),
              topLeft: Radius.circular(rounding)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Observer(builder: (context) {
                double animated =
                    scrollPos.interpolate(xs: [0, 0.6, 1], ys: [0, 0, 1]);
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 4.0,
                  width: 80 - animated * 80,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)),
                );
              }),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                listingHit.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 5.0),
                  Text(listingHit.subtitle.trim(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }
}
