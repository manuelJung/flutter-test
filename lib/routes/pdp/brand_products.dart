import 'package:flutter/material.dart';
import 'package:flutter_app/routes/listing/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:flutter_app/widgets/product_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    const listingFilter = InitialFilters(query: 'Besteck');
    return Provider(
      create: (_) => ProductListStore(listingFilter, []),
      child: Observer(builder: (context) {
        final store = context.read<ProductListStore>();
        return Column(children: [
          _teaser(context),
          if (!store.isFetching) ...[
            for (int i = 0; i < 3; i++) _createProductWidgetRow(context, i * 2)
          ],
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ListingRoute(initialFilters: listingFilter)));
            }),
            child: const Text('Mehr von Vega'),
          ),
        ]);
      }),
    );
  }

  Widget _teaser(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width * (2 / 3),
      child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.width * (2 / 3),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                  'https://res.cloudinary.com/lusini/image/fetch/w_900,f_auto,dpr_2/https%3A%2F%2Fres.cloudinary.com%2Flusini%2Fimage%2Fupload%2Fc_crop%2Cg_south%2Ch_1427%2Cw_2600%2Fv1631263004%2Fcms%2Fmam%2FVE2922M004WEISS_01.jpg'),
            ),
          ),
          Positioned(
              width: size.width,
              height: size.width * (2 / 3),
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Mehr von',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'VEGA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _createProductWidgetRow(BuildContext context, int index) {
    final store = context.read<ProductListStore>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (store.hits.length > index)
          ProductWidget(store: store, hitIndex: index),
        const SizedBox(width: 10),
        if (store.hits.length > index + 1)
          ProductWidget(store: store, hitIndex: index + 1)
        else
          const Expanded(child: Text('')),
      ],
    );
  }
}
