import 'package:flutter/material.dart';
import 'package:flutter_app/routes/listing/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  // @override
  Widget _build(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Lusini',
              style: TextStyle(color: Color.fromRGBO(214, 164, 68, 1))),
          pinned: true,
          backgroundColor: Colors.white,
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 40)),
        _categories(context),
        _title(context, 'Beliebt'),
        _beliebt(context),
        _title(context, 'Empfehlungen'),
        _suggestions(context),
      ],
    );
  }

  Widget _categories(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 50;
    final ratio = (size.width / 2) / itemHeight;
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: ratio,
        children: [
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
        ],
      ),
    );
  }

  Widget _beliebt(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
        children: [
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
        ],
      ),
    );
  }

  Widget _suggestions(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid.count(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2,
        children: [
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
          Container(height: 20, color: Colors.amber),
        ],
      ),
    );
  }

  Widget _title(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
