import 'package:flutter/material.dart';
import 'package:flutter_app/routes/listing/index.dart';

class HomeRoute extends StatelessWidget {
  static String path = 'home';

  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Open listing'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListingRoute()),
          );
        },
      )),
    );
  }
}
