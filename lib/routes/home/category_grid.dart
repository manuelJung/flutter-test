import 'package:flutter/material.dart';
import 'package:flutter_app/routes/listing/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 60;
    final ratio = (size.width / 2) / itemHeight;
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        childAspectRatio: ratio,
        children: [
          _renderItem(
            img: 'assets/home_glaeser.png',
            label: 'Gläßer',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListingRoute(
                        title: 'Gläßer',
                        initialFilters: InitialFilters(query: 'Gläser'))),
              );
            },
          ),
          _renderItem(
            img: 'assets/home_besteck.png',
            label: 'Besteck',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListingRoute(
                        title: 'Besteck',
                        initialFilters: InitialFilters(query: 'Besteck'))),
              );
            },
          ),
          _renderItem(
            img: 'assets/home_moebel.png',
            label: 'Möbel',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListingRoute(
                        title: 'Möbel',
                        initialFilters: InitialFilters(query: 'Möbel'))),
              );
            },
          ),
          _renderItem(
            img: 'assets/home_kleidung.png',
            label: 'Kleidung',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListingRoute(
                        title: 'Berufsbekleidung',
                        initialFilters:
                            InitialFilters(query: 'Berufsbekleidung'))),
              );
            },
          ),
          _renderItem(
            img: 'assets/home_besteck.png',
            label: 'Buffet',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListingRoute(
                        title: 'Buffet',
                        initialFilters: InitialFilters(query: 'Buffet'))),
              );
            },
          ),
          _renderItem(
            img: 'assets/home_take_away.png',
            label: 'Take-Away',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListingRoute(
                        title: 'Take-Away',
                        initialFilters: InitialFilters(query: 'Take-Away'))),
              );
            },
          ),
          _renderItem(
            img: 'assets/home_sale.png',
            label: 'Sale',
            onTab: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListingRoute(
                        title: 'Sale', initialFilters: InitialFilters())),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _renderItem({
    required String img,
    required String label,
    required void Function() onTab,
  }) {
    return InkWell(
      onTap: onTab,
      child: Container(
          color: Colors.grey[300],
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(img),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(label,
                          style:
                              const TextStyle(fontWeight: FontWeight.bold)))),
            ],
          )),
    );
  }
}
