class CartModel {
  final String productId;
  final String productName;
  final double price;
  final List<String> imageUrls;
  int quantity;
  final String vendorId;
  final int productQuantity;

  CartModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrls,
    required this.quantity,
    required this.vendorId,
    required this.productQuantity,
  });
}
