class CategoryModel {
  final String categoryName;
  final String categoryImage;

  CategoryModel({
    required this.categoryName,
    required this.categoryImage,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryName: map['categoryName'] ?? map['name'] ?? '',
      categoryImage: map['image'] ?? map['categoryImage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'image': categoryImage,
    };
  }
}
