import 'package:flutter/material.dart';

class WishlistRoute extends StatelessWidget {
  const WishlistRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
      child: const Center(
        child: Text('Wishlist'),
      ),
    );
  }
}
