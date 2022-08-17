import 'package:flutter/material.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final scrollPos = context.read<AnimatedValue>();
      return SliverAppBar(
        title: Center(
          child: Text('LUSINI',
              style: TextStyle(
                  letterSpacing: 4,
                  fontSize: scrollPos.interpolate(
                    xs: [0, 30, 31],
                    ys: [32, 0, 0],
                  ),
                  color: const Color.fromRGBO(214, 164, 68, 1))),
        ),
        pinned: true,
        expandedHeight: 130,
        collapsedHeight: 70,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.grey[300],
                  ),
                  height: 45,
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[700],
                        )),
                    Text(
                      'Suche...',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ]),
                )),
          ],
        ),
        backgroundColor: Colors.white,
      );
    });
  }
}
