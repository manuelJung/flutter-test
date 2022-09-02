class CategoryListingPage {
  final String id;
  final String category;
  final String title;
  CategoryListingPage({
    required this.id,
    required this.category,
    required this.title,
  });

  factory CategoryListingPage.fromJSON(dynamic map) {
    return CategoryListingPage(
      id: map['id'],
      category: map['category'],
      title: map['title'],
    );
  }
}
