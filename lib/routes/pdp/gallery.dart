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
    final PageController controller = PageController();
    return PageView.builder(
      itemCount: colors.length,
      controller: controller,
      pageSnapping: true,
      allowImplicitScrolling: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, pagePosition) {
        return Container(
          height: 20,
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
