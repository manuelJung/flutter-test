import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/gallery.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_app/stores/ui.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PDPRoute extends StatelessWidget {
  final ProductListStore store;
  final int index;
  const PDPRoute({super.key, required this.store, required this.index});

  @override
  Widget build(BuildContext context) {
    uiStore.showBottomNavigation = false;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: PageView.builder(
            itemCount: 3,
            pageSnapping: true,
            itemBuilder: (context, pagePosition) {
              var size = MediaQuery.of(context).size;
              double bottomSheetHeight = size.height - size.width;
              double radiusOffset = 10 / size.height;
              double draggablePercent =
                  (bottomSheetHeight / size.height) + radiusOffset;
              double maxDragablePercent = 1;
              return Stack(children: [
                SizedBox(
                  height: size.height - bottomSheetHeight,
                  child: VisibilityDetector(
                      key: Key('pdp-visiblity-detector$index'),
                      onVisibilityChanged: (info) => uiStore
                          .showBottomNavigation = info.visibleBounds.isEmpty,
                      child: const Gallery()),
                ),
                DraggableScrollableSheet(
                    initialChildSize: draggablePercent,
                    maxChildSize: maxDragablePercent,
                    minChildSize: draggablePercent,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                              color: Colors.white),
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: 25,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return const Placeholder(
                                  fallbackHeight: 200,
                                );
                              }));
                    })
              ]);
            }));
  }
}
