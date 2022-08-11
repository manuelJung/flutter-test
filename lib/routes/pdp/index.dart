import 'package:flutter/material.dart';
import 'package:flutter_app/routes/home/index.dart';
import 'package:flutter_app/routes/pdp/gallery.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_app/stores/ui.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PDPRoute extends StatelessWidget {
  final ProductListStore store;
  final int index;
  const PDPRoute({super.key, required this.store, required this.index});

  static const double initialBottomSheetHeight = 150;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: PageView.builder(
            itemCount: 3,
            pageSnapping: true,
            controller: controller,
            itemBuilder: (context, pagePosition) {
              double screenHeight = MediaQuery.of(context).size.height;
              double draggablePercent =
                  PDPRoute.initialBottomSheetHeight / screenHeight;
              double maxDragablePercent = 1 - 80 / screenHeight;
              DraggableScrollableController dragScrollController =
                  DraggableScrollableController();
              return Stack(children: [
                SizedBox(
                  height: screenHeight - PDPRoute.initialBottomSheetHeight,
                  child: const Gallery(),
                ),
                DraggableScrollableSheet(
                    initialChildSize: draggablePercent,
                    maxChildSize: maxDragablePercent,
                    minChildSize: draggablePercent,
                    controller: dragScrollController,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                          color: Colors.blue[100],
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: 25,
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
