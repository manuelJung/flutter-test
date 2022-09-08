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
              const Text(
                'Wähle deine Farbe',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  for (FilterOption row
                      in store.filters[FilterKey.color]?.options ?? [])
                    InkWell(
                      onTap: () {
                        store.filters[FilterKey.color]?.setValue(row.title);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: store.displayVariant
                                          .filters[FilterKey.color] ==
                                      row.title
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

  Widget _delimiter(BuildContext context) {
    return Container(
      height: 1,
      color: Colors.grey,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 20,
      ),
    );
  }
}
