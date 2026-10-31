import 'package:bobde6_multi_store/models/cart_model.dart';
import 'package:flutter/widgets.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems => _cartItems;

  double get totalPrice {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart({
    required String productId,
    required String productName,
    required double price,
    required List<String> imageUrls,
    required int quantity,
    required String vendorId,
    required int productQuantity,
  }) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCartItem) => CartModel(
          productId: existingCartItem.productId,
          productName: existingCartItem.productName,
          price: existingCartItem.price,
          imageUrls: existingCartItem.imageUrls,
          quantity: existingCartItem.quantity + quantity,
          vendorId: existingCartItem.vendorId,
          productQuantity: existingCartItem.productQuantity,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartModel(
          productId: productId,
          productName: productName,
          price: price,
          imageUrls: imageUrls,
          quantity: quantity,
          vendorId: vendorId,
          productQuantity: productQuantity,
        ),
      );
    }
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    if (_cartItems.containsKey(productId)) {
      if (_cartItems[productId]!.quantity > 1) {
        _cartItems[productId]!.quantity--;
      } else {
        _cartItems.remove(productId);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
