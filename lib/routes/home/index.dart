import 'package:flutter/material.dart';
import 'package:flutter_app/routes/home/category_grid.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('LUSINI',
                style: TextStyle(
                    letterSpacing: 4,
                    fontSize: 32,
                    color: Color.fromRGBO(214, 164, 68, 1))),
            pinned: true,
            backgroundColor: Colors.white,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const CategoryGrid(),
          _title(context, 'Beliebt'),
          _beliebt(context),
          _title(context, 'Empfehlungen'),
          _suggestions(context),
        ],
      ),
    );
  }

  Widget _beliebt(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10),
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
