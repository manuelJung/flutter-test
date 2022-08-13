import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/animations.dart';
import 'package:flutter_app/routes/pdp/gallery.dart';
import 'package:flutter_app/routes/pdp/sheet_box.dart';
import 'package:flutter_app/routes/pdp/sheet_title.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_app/stores/product_list/listing_hit.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_app/stores/ui/ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'animated_app_bar.dart';
import 'bottom_sheet.dart';
import 'back_button.dart';

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
                  double bottomSheetHeight = size.height - size.width;
                  double radiusOffset = 10 / size.height;
                  double draggablePercent =
                      (bottomSheetHeight / size.height) + radiusOffset;
                  double maxDragablePercent = 1;
                  double headerHeight = AnimatedAppBar.headerHeight;
                  double headerPercent = headerHeight / size.height;

                  return PDPPage(
                      size: size,
                      bottomSheetHeight: bottomSheetHeight,
                      hit: store.hits[pagePosition],
                      draggablePercent: draggablePercent,
                      headerPercent: headerPercent,
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
    required this.headerPercent,
    required this.maxDragablePercent,
    required this.hit,
  }) : super(key: key);

  final Size size;
  final double bottomSheetHeight;
  final double draggablePercent;
  final double headerPercent;
  final ListingHit hit;
  final double maxDragablePercent;

  @override
  State<PDPPage> createState() => _PDPPageState();
}

class _PDPPageState extends State<PDPPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
            create: (context) => PDPStore(
                containerID: widget.hit.productNumber, sku: widget.hit.sku)),
        Provider(create: (context) => BottomSheetAnimation()),
      ],
      child: Stack(children: [
        SizedBox(
          height: widget.size.height - widget.bottomSheetHeight,
          child: Gallery(
            fallbackImage: widget.hit.imgUrl,
          ),
        ),
        const CustomBackButton(),
        const AnimatedAppBar(),
        CustomBottomSheet(
          draggablePercent: widget.draggablePercent,
          headerPercent: widget.headerPercent,
          maxDragablePercent: widget.maxDragablePercent,
          children: [
            SheetTitle(
              listingHit: widget.hit,
            ),
            const SheetBox(),
            const SheetBox(),
            const SheetBox(),
            const SheetBox(),
            const SheetBox(),
            const SheetBox(),
          ],
        )
      ]),
    );
  }
}
