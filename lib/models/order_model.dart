class OrderModel {
  final String orderId;
  final String buyerId;
  final String productName;
  final double price;
  final int quantity;
  final String imageUrl;
  final String vendorId;
  final String orderStatus;
  final DateTime orderDate;

  OrderModel({
    required this.orderId,
    required this.buyerId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.vendorId,
    required this.orderStatus,
    required this.orderDate,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String docId) {
    return OrderModel(
      orderId: docId,
      buyerId: map['buyerId'] ?? '',
      productName: map['productName'] ?? '',
      price: (map['price'] is num) ? (map['price'] as num).toDouble() : 0.0,
      quantity: (map['quantity'] is num) ? (map['quantity'] as num).toInt() : 1,
      imageUrl: map['imageUrl'] ?? '',
      vendorId: map['vendorId'] ?? '',
      orderStatus: map['orderStatus'] ?? 'Pending',
      orderDate: map['orderDate'] != null
          ? (map['orderDate'] as dynamic).toDate()
          : DateTime.now(),
    );
  }
}
