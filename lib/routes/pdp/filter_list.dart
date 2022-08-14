import 'package:flutter/material.dart';
import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FilterList extends StatelessWidget {
  const FilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _delimiter(context),
          InkWell(
            onTap: () => Scaffold.of(context).showBottomSheet(
              (context) => Container(
                color: Colors.amber,
                height: 400,
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Farbe',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.chevron_right_rounded),
                ]),
          ),
          _delimiter(context),
          InkWell(
            onTap: () => Scaffold.of(context).showBottomSheet(
              (context) => Container(
                color: Colors.amber,
                height: 400,
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Größe',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.chevron_right_rounded),
                ]),
          ),
          _delimiter(context),
          const SizedBox(height: 20),
          Observer(builder: (context) {
            final store = context.read<PDPStore>();
            return Text(
              store.isFetching ? '' : store.displayVariant.description,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            );
          })
        ],
      ),
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
