import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/gallery.dart';
import 'package:flutter_app/routes/pdp/sheet_box.dart';
import 'package:flutter_app/routes/pdp/sheet_title.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_app/stores/ui/ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        body: Observer(builder: (context) {
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
        }));
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
  final Hit hit;
  final double maxDragablePercent;

  @override
  State<PDPPage> createState() => _PDPPageState();
}

class _PDPPageState extends State<PDPPage> {
  final scrollPos = AnimatedValue();
  final pdpStore = PDPStore(productNumber: '123456', sku: '12345678');

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: widget.size.height - widget.bottomSheetHeight,
        child: VisibilityDetector(
            key: Key('pdp-visiblity-detector${widget.hit.sku}'),
            onVisibilityChanged: (info) =>
                uiStore.showBottomNavigation = info.visibleBounds.isEmpty,
            child: Gallery(
              fallbackImage: widget.hit.imgUrl,
            )),
      ),
      CustomBackButton(scrollPos: scrollPos),
      AnimatedAppBar(scrollPos: scrollPos),
      CustomBottomSheet(
        scrollPos: scrollPos,
        draggablePercent: widget.draggablePercent,
        headerPercent: widget.headerPercent,
        maxDragablePercent: widget.maxDragablePercent,
        children: [
          SheetTitle(scrollPos: scrollPos),
          const SheetBox(),
          const SheetBox(),
          const SheetBox(),
          const SheetBox(),
          const SheetBox(),
          const SheetBox(),
        ],
      )
    ]);
  }
}
