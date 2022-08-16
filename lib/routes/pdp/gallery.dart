import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../stores/pdp/pdp.dart';

class Gallery extends StatefulWidget {
  final String fallbackImage;
  const Gallery({Key? key, required this.fallbackImage}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    PDPStore store = context.read<PDPStore>();
    var size = MediaQuery.of(context).size;
    return Observer(builder: ((context) {
      if (store.isFetching) return _loadingBuild(context);
      return Stack(
        children: [
          PageView.builder(
            itemCount: store.displayVariant.imgList.length,
            onPageChanged: (value) => setState(() {
              index = value;
            }),
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
          ),
          Observer(builder: (context) {
            var top = size.width / 2;
            if (store.isFetching || store.displayVariant.imgList.length <= 1) {
              return const SizedBox();
            }
            return Positioned(
                left: 10,
                top: top,
                width: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(children: [
                    for (int i = 0;
                        i < store.displayVariant.imgList.length;
                        i++)
                      Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: i == index
                                ? Colors.grey[800]
                                : Colors.grey[100]),
                      ),
                  ]),
                ));
          })
        ],
      );
    }));
  }

  // @override
  Widget _loadingBuild(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var img = widget.fallbackImage;

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
