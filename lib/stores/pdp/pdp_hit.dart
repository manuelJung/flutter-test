import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_app/utils/img_transform.dart';

class PDPHit {
  final String title;
  final String imgUrl;
  final List<String> imgList;
  final String sku;
  final Map<FilterKey, String> filters;
  // final String variant;
  // final String style;
  // final String size;
  // final String color;
  final bool isEmpty;
  const PDPHit({
    required this.title,
    required this.imgUrl,
    required this.filters,
    // required this.color,
    // required this.variant,
    // required this.style,
    // required this.size,
    required this.imgList,
    required this.sku,
    this.isEmpty = false,
  });

  factory PDPHit.empty() {
    return const PDPHit(
        title: '',
        isEmpty: true,
        imgUrl: '',
        filters: {
          FilterKey.color: '',
          FilterKey.size: '',
          FilterKey.style: '',
          FilterKey.variant: '',
        },
        imgList: [],
        sku: '');
  }

  bool match({
    required String color,
    required String size,
    required String variant,
    required String style,
  }) {
    if (filters[FilterKey.color] != '' &&
        color != '' &&
        filters[FilterKey.color] != color) return false;
    if (filters[FilterKey.size] != '' &&
        size != '' &&
        filters[FilterKey.size] != size) return false;
    if (filters[FilterKey.variant] != '' &&
        variant != '' &&
        filters[FilterKey.variant] != variant) {
      return false;
    }
    if (filters[FilterKey.style] != '' &&
        style != '' &&
        filters[FilterKey.style] != style) return false;
    return true;
  }

  factory PDPHit.fromAlgoliaHit(Map<String, dynamic> hit) {
    List<Map<String, dynamic>> imagesRaw = [...hit['images']['imageWeb']];
    return PDPHit(
        title: hit['title'],
        imgUrl: ImgTransform.generate(hit['images']['imageWeb'][0]),
        imgList: imagesRaw.map((e) => ImgTransform.generate(e)).toList(),
        filters: {
          FilterKey.color: hit['variantData']['color']['label'] ?? '',
          FilterKey.variant: hit['variantData']['variant']['label'] ?? '',
          FilterKey.style: hit['variantData']['style']['label'] ?? '',
          FilterKey.size: hit['variantData']['size']['label'] ?? '',
        },
        sku: hit['sku']);
  }
}
