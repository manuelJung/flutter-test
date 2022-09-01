import 'dart:convert';

import 'package:flutter_app/cms/cms_link.dart';

class HomePage {
  final String id;
  final String categoryLabel;
  final List<HomePageCategory> categories;
  final String brandLabel;
  final List<HomePageTeaser> brands;
  final String highlightsLabel;
  final List<HomePageTeaser> highlights;

  HomePage({
    required this.id,
    required this.categoryLabel,
    required this.categories,
    required this.brandLabel,
    required this.brands,
    required this.highlightsLabel,
    required this.highlights,
  });

  factory HomePage.fromJSON(dynamic map) {
    return HomePage(
      id: map['id'],
      categoryLabel: map['categoryLabel'],
      categories: [
        for (var row in map['categories'])
          HomePageCategory(
            label: row['imgUrl'],
            imgUrl: row['label'],
            to: CMSLink.fromMap(row['to']),
          )
      ],
      brandLabel: map['brandLabel'],
      brands: [
        for (var row in map['brands'])
          HomePageTeaser(
            label: row['imgUrl'],
            imgUrl: row['label'],
            to: CMSLink.fromMap(row['to']),
          )
      ],
      highlightsLabel: map['highlightsLabel'],
      highlights: [
        for (var row in map['brands'])
          HomePageTeaser(
            label: row['imgUrl'],
            imgUrl: row['label'],
            to: CMSLink.fromMap(row['to']),
          )
      ],
    );
  }
}

class HomePageCategory {
  final String label;
  final String imgUrl;
  final CMSLink to;

  HomePageCategory({
    required this.label,
    required this.imgUrl,
    required this.to,
  });
}

class HomePageTeaser {
  final String label;
  final String imgUrl;
  final CMSLink to;

  HomePageTeaser({
    required this.label,
    required this.imgUrl,
    required this.to,
  });
}
