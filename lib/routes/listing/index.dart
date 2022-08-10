import 'package:flutter/material.dart';
import '../pdp/index.dart';

class ListingRoute extends StatelessWidget {
  const ListingRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Open pdp'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PDPRoute()),
          );
        },
      )),
    );
  }
}
