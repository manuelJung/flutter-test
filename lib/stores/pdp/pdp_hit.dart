import 'package:flutter_app/stores/pdp/pdp.dart';
import 'package:flutter_app/utils/img_transform.dart';

class PDPHit {
  final String title;
  final String imgUrl;
  final List<String> imgList;
  final String sku;
  final Map<FilterKey, String> filters;
  final bool isEmpty;
  final String description;
  final String subtitle;
  const PDPHit({
    required this.title,
    required this.imgUrl,
    required this.filters,
    required this.imgList,
    required this.description,
    required this.subtitle,
    required this.sku,
    this.isEmpty = false,
  });

  factory PDPHit.empty() {
    return const PDPHit(
        title: '',
        isEmpty: true,
        imgUrl: '',
        description: '',
        subtitle: '',
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

  static List<String> algoliaAttributes = [
    'sku',
    'containerID',
    'images',
    'title',
    'description',
    'flags',
    'attributes',
    'variantData',
    'subtitle',
  ];

  factory PDPHit.fromAlgoliaHit(Map<String, dynamic> hit) {
    List<Map<String, dynamic>> imagesRaw = [...hit['images']['imageWeb']];
    return PDPHit(
        title: hit['title'],
        description: hit['description'],
        subtitle: hit['subtitle'],
        imgUrl: imagesRaw.isNotEmpty
            ? ImgTransform.generate(hit['images']['imageWeb'][0])
            : '',
        imgList: imagesRaw.isNotEmpty
            ? imagesRaw.map((e) => ImgTransform.generate(e)).toList()
            : [''],
        filters: {
          FilterKey.color: hit['variantData']['color']['label'] ?? '',
          FilterKey.variant: hit['variantData']['variant']['label'] ?? '',
          FilterKey.style: hit['variantData']['style']['label'] ?? '',
          FilterKey.size: hit['variantData']['size']['label'] ?? '',
        },
        sku: hit['sku']);
  }
}
