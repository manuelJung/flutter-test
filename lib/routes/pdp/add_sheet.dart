import 'package:flutter/material.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddSheet extends StatelessWidget {
  final PDPStore store;
  AddSheet({super.key, required this.store});

  int amount = 0;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return SizedBox(
      width: screen.width,
      height: 250,
      child: Observer(builder: (context) {
        return Column(
          children: [
            SizedBox(
              width: screen.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Text(
                  store.displayVariant.title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            _filter(context, store, FilterKey.color, 'Farbe'),
            _filter(context, store, FilterKey.size, 'Größe'),
            _filter(context, store, FilterKey.variant, 'Variante'),
            _filter(context, store, FilterKey.style, 'Stil'),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: StatefulBuilder(builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: amount > 1
                          ? (() => setState(
                                () => amount--,
                              ))
                          : null,
                      child: const Text('-'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(amount.toString()),
                    ),
                    ElevatedButton(
                      onPressed: (() => setState(
                            () => amount++,
                          )),
                      child: const Text('+'),
                    ),
                  ],
                );
              }),
            ),
            ElevatedButton(
                onPressed: (() {}), child: const Text('In den Warenkorb'))
          ],
        );
      }),
    );
  }

  Widget _filter(
      BuildContext context, PDPStore store, FilterKey key, String label) {
    final filter = store.filters[key]!;
    final screen = MediaQuery.of(context).size;
    var value = filter.value;
    if (filter.options.length == 1) value = filter.options[0].title;
    if (value == '') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: SizedBox(
        width: screen.width,
        child: Text(
          '$label: $value',
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
