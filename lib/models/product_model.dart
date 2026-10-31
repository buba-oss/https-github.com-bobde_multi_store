class ProductModel {
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  final String category;
  final String description;
  final List<String> imageUrls;
  final String vendorId;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.category,
    required this.description,
    required this.imageUrls,
    required this.vendorId,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String docId) {
    List<String> images = [];
    if (map['imageUrl'] is List) {
      images = List<String>.from(map['imageUrl']);
    } else if (map['imageUrl'] is String) {
      images = [map['imageUrl']];
    } else if (map['productImages'] is List) {
      images = List<String>.from(map['productImages']);
    }

    return ProductModel(
      productId: docId,
      productName: map['productName'] ?? '',
      price: (map['price'] is num) ? (map['price'] as num).toDouble() : 0.0,
      quantity: (map['quantity'] is num) ? (map['quantity'] as num).toInt() : 0,
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      imageUrls: images,
      vendorId: map['vendorId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'category': category,
      'description': description,
      'imageUrl': imageUrls,
      'vendorId': vendorId,
    };
  }
}
