import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list/listing_hit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'animations.dart';

class SheetTitle extends StatelessWidget {
  const SheetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    var listingHit = context.read<ListingHit>();
    var scrollPos = context.read<BottomSheetAnimation>();
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0))),
      height: 100,
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
  }
}
