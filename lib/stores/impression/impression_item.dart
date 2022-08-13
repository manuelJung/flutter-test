import '../../utils/img_transform.dart';

class ImpressionItem {
  final String img;
  final String containerID;
  final List<String> skus;
  ImpressionItem(
      {required this.img, required this.skus, required this.containerID});

  static bool hasMilieu(Map<String, dynamic> hit) {
    List<dynamic> images = [...hit['images']['imageWeb']]
        .map((el) => el['classes'] as List<dynamic>)
        .where((el) => el.contains('ASSET_M'))
        .toList();

    return images.isNotEmpty;
  }

  factory ImpressionItem.fromAlgoliaHit(Map<String, dynamic> hit) {
    List<dynamic> images = hit['images']['imageWeb'];
    dynamic image =
        images.firstWhere((el) => el['classes'].contains('ASSET_M'));
    return ImpressionItem(
        containerID: hit['containerID'],
        img: ImgTransform.generate(image),
        skus: [hit['sku'], '30051116', '10051235', '30002537']);
  }
}
