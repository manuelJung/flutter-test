import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  final String fallbackImage;
  const Gallery({Key? key, required this.fallbackImage}) : super(key: key);

  final List<MaterialColor> colors = const [
    Colors.blue,
    Colors.amber,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return _loadingBild(context);
    // return PageView.builder(
    //   itemCount: colors.length,
    //   pageSnapping: true,
    //   allowImplicitScrolling: true,
    //   physics: const ClampingScrollPhysics(),
    //   scrollDirection: Axis.vertical,
    //   itemBuilder: (context, pagePosition) {
    //     return Container(
    //       width: double.infinity,
    //       color: colors[pagePosition],
    //       child: Center(
    //         child: Text('Img $pagePosition',
    //             style: Theme.of(context).textTheme.headline4),
    //       ),
    //     );
    //   },
    // );
  }

  Widget _loadingBild(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Image.network(fallbackImage,
        width: size.width - 20, height: size.width - 20);
  }
}
