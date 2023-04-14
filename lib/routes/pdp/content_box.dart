import 'package:flutter/material.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({super.key});

  @override
  Widget build(BuildContext context) {
    var store = context.read<PDPStore>();
    return SliverToBoxAdapter(
      child: Observer(builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...getColor(context),
              ...getFilter(
                  context: context,
                  key: FilterKey.size,
                  labelSingle: 'Größe',
                  labelMulti: 'Wähle deine Größe'),
              ...getFilter(
                  context: context,
                  key: FilterKey.variant,
                  labelSingle: 'Variante',
                  labelMulti: 'Wähle deine Variante'),
              ...getFilter(
                  context: context,
                  key: FilterKey.style,
                  labelSingle: 'Stil',
                  labelMulti: 'Wähle deinen Stil'),
              const SizedBox(height: 20),
              _delimiter(context),
              Observer(builder: (context) {
                final store = context.read<PDPStore>();
                return Text(
                  store.isFetching || store.hits.isEmpty
                      ? ''
                      : store.displayVariant.description,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                );
              })
            ],
          ),
        );
      }),
    );
  }

  List<Widget> getColor(BuildContext context) {
    final store = context.read<PDPStore>();
    if (store.filters[FilterKey.color]!.options.isEmpty) return [];

    if (store.filters[FilterKey.color]!.options.length == 1) return [];

    return [
      const Text(
        'Wähle deine Farbe',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (FilterOption row
                in store.filters[FilterKey.color]?.options ?? [])
              InkWell(
                onTap: () {
                  if (row.selectable) {
                    store.filters[FilterKey.color]?.setValue(row.title);
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            store.filters[FilterKey.color]!.value == row.title
                                ? Colors.black
                                : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      right: 10,
                      top: 10,
                    ),
                    width: 80,
                    height: 120,
                    child: Image.network(row.img ?? '')),
              )
          ],
        ),
      )
    ];
  }

  List<Widget> getFilter({
    required BuildContext context,
    required FilterKey key,
    required String labelSingle,
    required String labelMulti,
  }) {
    final store = context.read<PDPStore>();
    var options = store.filters[key]!.options;
    if (options.isEmpty) return const [];

    if (options.length == 1) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            '$labelSingle: ${options[0].title}',
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ];
    }

    return [
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          labelMulti,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var opt in options)
              InkWell(
                onTap: () {
                  if (opt.selectable) {
                    store.filters[key]!.setValue(opt.title);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: store.filters[key]!.value == opt.title
                      ? Colors.grey
                      : opt.selectable
                          ? Colors.grey[300]
                          : Colors.grey[100],
                  child: Text(
                    opt.title,
                    style: TextStyle(
                      color: opt.selectable ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
          ],
        ),
      )
    ];
  }

  Widget _delimiter(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey[300],
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
    );
  }
}
