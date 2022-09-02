import 'package:flutter_app/cms/cms_link.dart';

class HomePage {
  final String id;
  final String categoryLabel;
  final List<HomePageCategory> categories;
  final String brandLabel;
  final List<HomePageTeaser> brands;
  final String imgGrid1Label;
  final List<HomePageTeaser> imgGrid1;
  final String imgGrid2Label;
  final List<HomePageTeaser> imgGrid2;

  HomePage({
    required this.id,
    required this.categoryLabel,
    required this.categories,
    required this.brandLabel,
    required this.brands,
    required this.imgGrid1Label,
    required this.imgGrid1,
    required this.imgGrid2Label,
    required this.imgGrid2,
  });

  factory HomePage.fromJSON(dynamic map) {
    return HomePage(
      id: map['id'],
      categoryLabel: map['categoryLabel'],
      categories: [
        for (var row in map['categories'])
          HomePageCategory(
            label: row['label'],
            imgUrl: row['imgUrl'],
            to: CMSLink.fromMap(row['to']),
          )
      ],
      brandLabel: map['brandLabel'],
      brands: [
        for (var row in map['brands'])
          HomePageTeaser(
            label: row['label'],
            imgUrl: row['imgUrl'],
            to: CMSLink.fromMap(row['to']),
          )
      ],
      imgGrid1Label: map['imgGrid1Label'],
      imgGrid1: [
        for (var row in map['imgGrid1'])
          HomePageTeaser(
            label: row['label'],
            imgUrl: row['imgUrl'],
            to: CMSLink.fromMap(row['to']),
          )
      ],
      imgGrid2Label: map['imgGrid2Label'],
      imgGrid2: [
        for (var row in map['imgGrid2'])
          HomePageTeaser(
            label: row['label'],
            imgUrl: row['imgUrl'],
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
