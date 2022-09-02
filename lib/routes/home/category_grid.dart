import 'package:flutter/material.dart';
import 'package:flutter_app/cms/cms_store.dart';
import 'package:flutter_app/cms/home_page.dart';
import 'package:flutter_app/routes/home/home_title.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CategoryGrid extends StatelessWidget {
  final String title;
  final List<HomePageCategory> rows;
  const CategoryGrid({super.key, required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 60;
    final ratio = (size.width / 2) / itemHeight;
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: HomeTitle(title: title),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            childAspectRatio: ratio,
            children: [
              for (var row in rows)
                InkWell(
                  onTap: (() =>
                      context.read<CMSStore>().navigate(context, row.to)),
                  child: Container(
                      color: Colors.grey[300],
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(row.imgUrl),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(row.label,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)))),
                        ],
                      )),
                )
            ],
          ),
        ),
      ],
    );
  }
}
