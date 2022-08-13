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
    return Observer(builder: ((context) {
      if (store.isFetching) return _loadingBuild(context);

      var size = MediaQuery.of(context).size;
      return PageView.builder(
        itemCount: store.displayVariant.imgList.length,
        pageSnapping: true,
        allowImplicitScrolling: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Center(
            child: Image.network(store.displayVariant.imgList[index],
                width: size.width - 20, height: size.width - 20),
          );
        },
      );
    }));
  }

  Widget _loadingBuild(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Image.network(fallbackImage,
          width: size.width - 20, height: size.width - 20),
    );
  }
}
