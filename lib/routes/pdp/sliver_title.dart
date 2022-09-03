import 'package:flutter/material.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_app/stores/product_list/listing_hit.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'animations.dart';

class SliverTitle extends StatelessWidget {
  const SliverTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final pos = context.read<BottomSheetAnimation>();
    final hit = context.read<ListingHit>();
    final store = context.read<PDPStore>();
    return Observer(builder: (context) {
      return SliverAppBar(
        pinned: true,
        leading: Container(),
        backgroundColor: pos.value >= 0.9 ? Colors.white : Colors.transparent,
        collapsedHeight: 90,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1,
            color: Colors.grey[300]!,
          ))),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                height: 25,
                child: Center(
                    child: Container(
                  width: pos.interpolate(xs: [0, 0.8, 1], ys: [120, 0, 0]),
                  height: 4,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                )),
              ),
              Expanded(
                  child: Row(
                children: [
                  SizedBox(
                    width: pos.interpolate(
                      xs: [0, 0.5, 1, 2],
                      ys: [10, 10, 60, 60],
                    ),
                    child: Center(
                        child: Opacity(
                            opacity: pos.interpolate(
                              xs: [0, 0.7, 1, 2],
                              ys: [0, 0, 1, 1],
                            ),
                            child: BackButton(
                              onPressed: () {
                                context.read<ScrollController>().jumpTo(0);
                                context
                                    .read<DraggableScrollableController>()
                                    .animateTo(
                                      0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                              },
                            ))),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hit.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                          store.isFetching
                              ? hit.subtitle
                              : store.displayVariant.subtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  )),
                ],
              )),
            ],
          ),
        ),
      );
    });
  }
}
