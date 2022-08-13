import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const Center(
          child: Text('88.90 €',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ElevatedButton(
          onPressed: (() {}),
          child: const Text('Hinzufügen'),
        )
      ]),
    );
  }
}
