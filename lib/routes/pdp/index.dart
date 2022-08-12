import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/gallery.dart';
import 'package:flutter_app/routes/pdp/sheet_box.dart';
import 'package:flutter_app/routes/pdp/sheet_title.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_app/stores/ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: const BackButton(color: Colors.black)),
        body: Observer(builder: (context) {
          return PageView.builder(
              itemCount: store.hits.length,
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              controller: PageController(
                  initialPage: index, keepPage: true, viewportFraction: 1),
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
                        child: Gallery(
                          fallbackImage: store.hits[pagePosition].imgUrl,
                        )),
                  ),
                  DraggableScrollableSheet(
                      initialChildSize: draggablePercent,
                      maxChildSize: maxDragablePercent,
                      minChildSize: draggablePercent,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          color: Colors.grey[200],
                          child: Column(
                            children: [
                              // const SheetTitle(),
                              Expanded(
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView(
                                    controller: scrollController,
                                    physics: const ClampingScrollPhysics(),
                                    children: const [
                                      SheetTitle(),
                                      SheetBox(),
                                      SheetBox(),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })
                ]);
              });
        }));
  }
}
