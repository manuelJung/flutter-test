import 'package:flutter/material.dart';

class WishlistRoute extends StatelessWidget {
  const WishlistRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Wishlist'),
              ),
            ),
            SizedBox(height: 200),
            Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Wishlist'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
