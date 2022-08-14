import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../stores/pdp/pdp.dart';

class Gallery extends StatelessWidget {
  final String fallbackImage;
  const Gallery({Key? key, required this.fallbackImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PDPStore store = context.read<PDPStore>();
    var size = MediaQuery.of(context).size;
    return Observer(builder: ((context) {
      if (store.isFetching) return _loadingBuild(context);
      return PageView.builder(
        itemCount: store.displayVariant.imgList.length,
        pageSnapping: true,
        allowImplicitScrolling: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var img = store.displayVariant.imgList[index];

          if (img.contains('c_fill')) {
            return SizedBox(
              width: size.width,
              height: size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(img),
              ),
            );
          }

          return Image.network(img, width: size.width, height: size.width);
        },
      );
    }));
  }

  // @override
  // Widget build(BuildContext context) {
  //   PDPStore store = context.read<PDPStore>();
  //   var size = MediaQuery.of(context).size;
  //   return Observer(builder: ((context) {
  //     if (store.isFetching) return _loadingBuild(context);
  //     return Column(
  //       children: [
  //         SizedBox(
  //           width: size.width,
  //           height: size.width,
  //           child: PageView.builder(
  //             itemCount: store.displayVariant.imgList.length,
  //             pageSnapping: true,
  //             allowImplicitScrolling: true,
  //             physics: const ClampingScrollPhysics(),
  //             scrollDirection: Axis.vertical,
  //             itemBuilder: (context, index) {
  //               return Center(
  //                 child: Image.network(store.displayVariant.imgList[index],
  //                     width: size.width, height: size.width),
  //               );
  //             },
  //           ),
  //         ),
  //         Builder(builder: (context) {
  //           final avHeight = size.height - size.width - 200;
  //           final nItems = store.displayVariant.imgList.length - 1;

  //           double itemSize = 0;

  //           if (avHeight * nItems < size.width) {
  //             itemSize = avHeight;
  //           } else if ((avHeight / 2) * nItems < size.width) {
  //             itemSize = avHeight / 2;
  //           } else if ((avHeight / 3) * nItems < size.width) {
  //             itemSize = avHeight / 3;
  //           }

  //           return SizedBox(
  //             height: avHeight,
  //             child: Wrap(runAlignment: WrapAlignment.start, children: [
  //               for (var i = 1; i < nItems + 1; i++)
  //                 Image.network(
  //                   store.displayVariant.imgList[i],
  //                   width: itemSize,
  //                   height: itemSize,
  //                 )
  //             ]),
  //           );
  //         }),
  //       ],
  //     );
  //   }));
  // }

  Widget _loadingBuild(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var img = fallbackImage;

    if (img.contains('c_fill')) {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.network(img),
        ),
      );
    }

    return Image.network(img, width: size.width, height: size.width);
  }
}
