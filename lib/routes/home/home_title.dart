import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  const HomeTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
