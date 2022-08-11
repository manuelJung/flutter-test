import 'package:flutter/material.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:provider/provider.dart';

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
