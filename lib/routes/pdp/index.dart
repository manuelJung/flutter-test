import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/animations.dart';
import 'package:flutter_app/routes/pdp/gallery.dart';
import 'package:flutter_app/routes/pdp/sliver_title.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_app/stores/product_list/listing_hit.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_app/stores/ui/ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'bottom_sheet.dart';

class PDPRoute extends StatelessWidget {
  final ProductListStore store;
  final int index;

  const PDPRoute({super.key, required this.store, required this.index});

  @override
  Widget build(BuildContext context) {
    uiStore.showBottomNavigation = false;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //     elevation: 0,
        //     backgroundColor: Colors.transparent,
        //     leading: const BackButton(color: Colors.black)),
        body: VisibilityDetector(
          key: Key('pdp-visibility-${store.hits[index].sku}'),
          onVisibilityChanged: (info) =>
              uiStore.showBottomNavigation = info.visibleBounds.isEmpty,
          child: Observer(builder: (context) {
            return PageView.builder(
                itemCount: store.hits.length,
                pageSnapping: true,
                physics: const ClampingScrollPhysics(),
                // physics: scrollPos.value > 0.5
                //     ? const NeverScrollableScrollPhysics()
                //     : const ClampingScrollPhysics(),
                controller: PageController(
                    initialPage: index, keepPage: true, viewportFraction: 1),
                itemBuilder: (context, pagePosition) {
                  var size = MediaQuery.of(context).size;
                  double bottomSheetHeight = 180;
                  double radiusOffset = 10 / size.height;
                  double draggablePercent =
                      (bottomSheetHeight / size.height) + radiusOffset;
                  double maxDragablePercent = 1;

                  return PDPPage(
                      size: size,
                      bottomSheetHeight: bottomSheetHeight,
                      hit: store.hits[pagePosition],
                      draggablePercent: draggablePercent,
                      maxDragablePercent: maxDragablePercent);
                });
          }),
        ));
  }
}

class PDPPage extends StatefulWidget {
  const PDPPage({
    Key? key,
    required this.size,
    required this.bottomSheetHeight,
    required this.draggablePercent,
    required this.maxDragablePercent,
    required this.hit,
  }) : super(key: key);

  final Size size;
  final double bottomSheetHeight;
  final double draggablePercent;
  final ListingHit hit;
  final double maxDragablePercent;

  @override
  State<PDPPage> createState() => _PDPPageState();
}

class Holder {
  final DraggableScrollableController controller;
  const Holder(this.controller);
}

class _PDPPageState extends State<PDPPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => widget.hit),
        Provider(
          create: (_) => PDPStore(
            containerID: widget.hit.productNumber,
            sku: widget.hit.sku,
          ),
        ),
        Provider(create: (_) => BottomSheetAnimation()),
      ],
      builder: (context, child) => Stack(children: [
        SizedBox(
          height: widget.size.height - widget.bottomSheetHeight,
          child: Gallery(
            fallbackImage: widget.hit.imgUrl,
          ),
        ),
        _backButton(context),
        CustomBottomSheet(
          draggablePercent: widget.draggablePercent,
          maxDragablePercent: widget.maxDragablePercent,
          children: [
            const SliverTitle(),
            SliverToBoxAdapter(child: Container(height: 500)),
            SliverToBoxAdapter(child: Container(height: 500)),
          ],
        )
      ]),
    );
  }

  Widget _backButton(BuildContext context) {
    return Observer(builder: (context) {
      var scrollPos = context.read<BottomSheetAnimation>();
      double size = scrollPos.interpolate(
        xs: [0, 0.4, 0.8, 1],
        ys: [1, 1, 0, 0],
      );
      return Opacity(
        opacity: size,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100)),
          width: 50,
          height: 50,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(top: 30, left: 10),
          child: Center(
              child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: size * 20,
            ),
            onPressed: () => Navigator.pop(context),
          )),
        ),
      );
    });
  }
}
