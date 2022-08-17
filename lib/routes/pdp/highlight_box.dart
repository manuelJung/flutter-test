import 'package:flutter/material.dart';

class HighlightBox extends StatelessWidget {
  const HighlightBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        height: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Center(
            child: Text('88.90 €',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: (() => Scaffold.of(context).showBottomSheet(
                  (context) => Container(
                    color: Colors.amber,
                    height: 400,
                  ),
                )),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Größe wählen',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
