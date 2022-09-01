enum CMSPageType { home }

class CMSLink {
  final String id;
  final CMSPageType type;

  static CMSPageType getPageType(String s) {
    return CMSPageType.values
        .firstWhere((e) => e.toString() == 'CMSPageType.$s');
  }

  CMSLink(this.id, this.type);

  factory CMSLink.fromMap(dynamic map) {
    return CMSLink(map['id'], getPageType(map['content_type']));
  }
}
