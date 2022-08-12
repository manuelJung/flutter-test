import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  final List<MaterialColor> colors = const [
    Colors.blue,
    Colors.amber,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: colors.length,
      pageSnapping: true,
      allowImplicitScrolling: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, pagePosition) {
        return Container(
          width: double.infinity,
          color: colors[pagePosition],
          child: Center(
            child: Text('Img $pagePosition',
                style: Theme.of(context).textTheme.headline4),
          ),
        );
      },
    );
  }
}
