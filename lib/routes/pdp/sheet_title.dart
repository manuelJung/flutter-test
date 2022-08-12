import 'package:flutter/material.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SheetTitle extends StatelessWidget {
  final AnimatedValue scrollPos;
  const SheetTitle({super.key, required this.scrollPos});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Observer(builder: (context) {
              double animated =
                  scrollPos.interpolate(xs: [0, 0.6, 1], ys: [0, 0, 1]);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 4.0,
                width: 80 - animated * 80,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10.0)),
              );
            }),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Operational Hours',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                SizedBox(height: 20.0),
                Text('Select days to add hours'),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
