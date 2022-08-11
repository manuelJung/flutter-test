import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DisjunctiveFilterRoute extends StatelessWidget {
  final DisjunctiveFilterStore store;
  const DisjunctiveFilterRoute({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(store.label),
        ),
        body: ListView.builder(
          itemCount: store.options.length,
          itemBuilder: ((context, index) {
            final option = store.options[index];
            return Observer(builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: store.values.contains(option)
                      ? Colors.amber
                      : Colors.transparent,
                  border: const Border(bottom: BorderSide()),
                ),
                child: ListTile(
                  title: Text(option),
                  onTap: (() => store.toggleValue(option)),
                ),
              );
            });
          }),
        ));
  }
}
