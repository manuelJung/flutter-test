import 'package:flutter/material.dart';

class PDPRoute extends StatelessWidget {
  static String path = 'pdp';

  const PDPRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDP'),
        ),
        body: const Center(child: Text('PDP!')));
  }
}