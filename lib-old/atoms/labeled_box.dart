import 'package:flutter/material.dart';

class LabeledBox extends StatelessWidget {
  final String label;
  final Widget child;
  const LabeledBox({Key? key, required this.child, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child:
                Text(label, style: const TextStyle(fontSize: 20, height: 3))),
        child
      ],
    );
  }
}
