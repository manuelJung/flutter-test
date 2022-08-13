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
    String imgHost =
        'https://res.cloudinary.com/lusini/w_500,h_500,q_70,c_pad,f_auto';
    return ListingHit(
        title: hit['title'],
        sku: hit['sku'],
        subtitle: hit['subtitle'],
        productNumber: hit['containerID'],
        imgUrl: '$imgHost/${hit['images']['imageWeb'][0]['url']}');
  }
}
