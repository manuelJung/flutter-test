class PDPHit {
  final String title;
  final String imgUrl;
  final List<String> imgList;
  final String sku;
  final String variant;
  final String style;
  final String size;
  final String color;
  final bool isEmpty;
  const PDPHit({
    required this.title,
    required this.imgUrl,
    required this.color,
    required this.variant,
    required this.style,
    required this.size,
    required this.imgList,
    required this.sku,
    this.isEmpty = false,
  });

  factory PDPHit.empty() {
    return const PDPHit(
        title: '',
        isEmpty: true,
        imgUrl: '',
        color: '',
        variant: '',
        style: '',
        size: '',
        imgList: [],
        sku: '');
  }

  bool match({
    required String color,
    required String size,
    required String variant,
    required String style,
  }) {
    if (this.color != '' && color != '' && this.color != color) return false;
    if (this.size != '' && size != '' && this.size != size) return false;
    if (this.variant != '' && variant != '' && this.variant != variant) {
      return false;
    }
    if (this.style != '' && style != '' && this.style != style) return false;
    return true;
  }

  factory PDPHit.fromAlgoliaHit(Map<String, dynamic> hit) {
    List<Map<String, dynamic>> imagesRaw = [...hit['images']['imageWeb']];
    String imgHost =
        'https://res.cloudinary.com/lusini/w_500,h_500,q_70,c_pad,f_auto';
    List<String> images = [];
    for (var img in imagesRaw) {
      if (img['classes'].contains('ASSET_M')) {
        String imgHost =
            'https://res.cloudinary.com/lusini/w_500,h_500,g_auto,q_70,c_fill,f_auto';
        images.add('$imgHost/${img['url']}');
      } else {
        images.add('$imgHost/${img['url']}');
      }
    }
    return PDPHit(
        title: hit['title'],
        imgUrl: '$imgHost/${hit['images']['imageWeb'][0]['url']}',
        imgList: images,
        color: hit['variantData']['color']['label'] ?? '',
        variant: hit['variantData']['variant']['label'] ?? '',
        style: hit['variantData']['style']['label'] ?? '',
        size: hit['variantData']['size']['label'] ?? '',
        sku: hit['sku']);
  }
}
