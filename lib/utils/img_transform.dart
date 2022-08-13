class ImgTransform {
  static String generate(Map<String, dynamic> json) {
    assert(json.containsKey('url'));
    assert(json.containsKey('classes'));
    if (json['classes'].contains('ASSET_M')) {
      return milieu(json['url']);
    } else {
      return freisteller(json['url']);
    }
  }

  static String freisteller(String path) {
    return 'https://res.cloudinary.com/lusini/w_500,h_500,q_70,c_pad,f_auto/$path';
  }

  static String milieu(String path) {
    return 'https://res.cloudinary.com/lusini/w_500,h_500,g_auto,q_70,c_fill,f_auto/$path';
  }
}
