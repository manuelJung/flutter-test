import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/gallery.dart';
import 'package:flutter_app/routes/pdp/sheet_box.dart';
import 'package:flutter_app/routes/pdp/sheet_title.dart';
import 'package:flutter_app/stores/animated_value.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_app/stores/ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'animated_app_bar.dart';
import 'bottom_sheet.dart';

class PDPRoute extends StatefulWidget {
  final ProductListStore store;
  final int index;

  const PDPRoute({super.key, required this.store, required this.index});

  @override
  State<PDPRoute> createState() => _PDPRouteState();
}

class _PDPRouteState extends State<PDPRoute> {
  final scrollPos = AnimatedValue();

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
              itemCount: widget.store.hits.length,
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              controller: PageController(
                  initialPage: widget.index,
                  keepPage: true,
                  viewportFraction: 1),
              itemBuilder: (context, pagePosition) {
                var size = MediaQuery.of(context).size;
                double bottomSheetHeight = size.height - size.width;
                double radiusOffset = 10 / size.height;
                double draggablePercent =
                    (bottomSheetHeight / size.height) + radiusOffset;
                double maxDragablePercent = 1;
                double headerHeight = AnimatedAppBar.headerHeight;
                double headerPercent = headerHeight / size.height;
                return Stack(children: [
                  SizedBox(
                    height: size.height - bottomSheetHeight,
                    child: VisibilityDetector(
                        key: Key('pdp-visiblity-detector${widget.index}'),
                        onVisibilityChanged: (info) => uiStore
                            .showBottomNavigation = info.visibleBounds.isEmpty,
                        child: Gallery(
                          fallbackImage: widget.store.hits[pagePosition].imgUrl,
                        )),
                  ),
                  AnimatedAppBar(scrollPos: scrollPos),
                  CustomBottomSheet(
                    scrollPos: scrollPos,
                    draggablePercent: draggablePercent,
                    headerPercent: headerPercent,
                    maxDragablePercent: maxDragablePercent,
                    children: [
                      SheetTitle(counter: scrollPos),
                      const SheetBox(),
                      const SheetBox(),
                      const SheetBox(),
                      const SheetBox(),
                      const SheetBox(),
                      const SheetBox(),
                    ],
                  )
                ]);
              });
        }));
  }
}
