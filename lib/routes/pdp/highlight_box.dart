import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/routes/pdp/add_sheet.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'animations.dart';

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
          Observer(builder: (context) {
            final btnlabel = _getButtonLabel(context);
            final canAdd = _canAdd(context);
            final store = context.read<PDPStore>();
            return ElevatedButton(
              onPressed: !canAdd && btnlabel == 'In den Warenkorb'
                  ? null
                  : (() {
                      if (canAdd) {
                        Scaffold.of(context).showBottomSheet(
                          (context) => AddSheet(store: store),
                        );
                      } else {
                        context.read<DraggableScrollableController>().animateTo(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                      }
                    }),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                btnlabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          })
        ]),
      ),
    );
  }

  String _getButtonLabel(BuildContext context) {
    final store = context.read<PDPStore>();
    final bs = context.read<BottomSheetAnimation>();
    if (bs.value > 0.8 || _canAdd(context)) {
      return 'In den Warenkorb';
    }
    final color = store.filters[FilterKey.color]!;
    if (color.options.length > 1 && color.value == '') {
      return 'Farbe wählen';
    }
    final size = store.filters[FilterKey.size]!;
    if (size.options.length > 1 && size.value == '') {
      return 'Größe wählen';
    }
    final variant = store.filters[FilterKey.variant]!;
    if (variant.options.length > 1 && variant.value == '') {
      return 'Variante wählen';
    }
    final style = store.filters[FilterKey.style]!;
    if (style.options.length > 1 && style.value == '') {
      return 'Stil wählen';
    }
    return 'In den Warenkorb';
  }

  bool _canAdd(BuildContext context) {
    final store = context.read<PDPStore>();
    if (store.isFetching) return false;
    final color = store.filters[FilterKey.color]!;
    if (color.options.length > 1 && color.value == '') {
      return false;
    }
    final size = store.filters[FilterKey.size]!;
    if (size.options.length > 1 && size.value == '') {
      return false;
    }
    final variant = store.filters[FilterKey.variant]!;
    if (variant.options.length > 1 && variant.value == '') {
      return false;
    }
    final style = store.filters[FilterKey.style]!;
    if (style.options.length > 1 && style.value == '') {
      return false;
    }
    return true;
  }
}
