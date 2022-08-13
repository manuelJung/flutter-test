import 'package:flutter_app/utils/img_transform.dart';

class ListingHit {
  final String title;
  final String imgUrl;
  final String sku;
  final String productNumber;
  final String subtitle;
  const ListingHit(
      {required this.title,
      required this.imgUrl,
      required this.sku,
      required this.subtitle,
      required this.productNumber});

  factory ListingHit.fromAlgolia(Map<String, dynamic> hit) {
    return ListingHit(
        title: hit['title'],
        sku: hit['sku'],
        subtitle: hit['subtitle'],
        productNumber: hit['containerID'],
        imgUrl: ImgTransform.generate(hit['images']['imageWeb'][0]));
  }
}
