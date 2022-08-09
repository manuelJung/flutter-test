import 'package:flutter/material.dart';
import 'package:flutter_app/containers/app_scaffold.dart';
import 'package:flutter_app/routes/pdp.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../stores/navigation.dart';
import '../stores/mobx/product_list.dart';

class ProductListRoute extends StatelessWidget {
  const ProductListRoute({Key? key}) : super(key: key);

  static const routeName = '/product-list';

  @override
  Widget build(BuildContext context) {
    // var store = ProductList(const InitialFilters(), []);
    return Provider<ProductList>(
      create: (_) => ProductList(const InitialFilters(), []),
      builder: (context, _) => AppScaffold(
          appBarTitle: 'P-L',
          body: Center(child: Observer(builder: (_) {
            var store = context.read<ProductList>();
            return ListView.builder(
                itemCount: (store.hits.length / 2).ceil() + 1,
                itemBuilder: (context, i) {
                  if (i == (store.hits.length / 2).ceil()) {
                    return const LoadingIndicator();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProductWidget(hit: store.hits[i * 2 + 0]),
                      (store.hits.length - 2) >= (i * 2)
                          ? ProductWidget(hit: store.hits[i * 2 + 1])
                          : const Expanded(child: Text(''))
                    ],
                  );
                });
          }))),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProductList>().incrementPage();
    return const SizedBox(
      height: 500,
      child: Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Hit hit;
  const ProductWidget({Key? key, required this.hit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        context.read<NavigationCubit>().push(const PDP(productNumber: 'TEST'));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            const Placeholder(fallbackHeight: 400),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                hit.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 20, height: 1.5),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
