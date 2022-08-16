import 'package:flutter/material.dart';
import 'package:flutter_app/routes/listing/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Open listing'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ListingRoute(
                    initialFilters: InitialFilters(category: 'Taschen'))),
          );
        },
      )),
    );
  }

  // @override
  Widget _build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Lusini',
              style: TextStyle(color: Color.fromRGBO(214, 164, 68, 1))),
          pinned: true,
          backgroundColor: Colors.white,
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
        categories(context)
      ],
    );
  }

  Widget categories(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverGrid.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 3,
      children: [
        Container(height: 20, color: Colors.amber),
        Container(height: 20, color: Colors.amber),
        Container(height: 20, color: Colors.amber),
        Container(height: 20, color: Colors.amber),
        Container(height: 20, color: Colors.amber),
        Container(height: 20, color: Colors.amber),
      ],
    );
  }
}
